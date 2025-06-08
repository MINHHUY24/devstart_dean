import 'dart:convert';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/Questions_model.dart';
import '../../../services/lessons_service.dart';

class LevelController extends GetxController with StateMixin<List<QuestionsModel>> {
  final LessonsService _lessonsService = LessonsService();
  final unlockedLevel = 1.obs;

  final selectedCourse = ''.obs;
  final selectedLevel = 1.obs;
  final selectedTopic = RxnString(); // nullable string



  @override
  void onInit() {
    super.onInit();
    print('LevelController initialized');

    everAll([selectedCourse, selectedLevel, selectedTopic], (_) {
      final course = selectedCourse.value;
      final level = selectedLevel.value;
      final topic = selectedTopic.value;

      print('Selected course: $course');
      print('Selected level: $level');
      print('Selected topic: ${topic ?? 'null'}'); // Log rõ hơn

      // Chỉ fetch khi course khác rỗng và topic khác null và khác rỗng
      if (course.isNotEmpty && topic != null && topic.isNotEmpty) {
        fetchQuestions(
          course: course,
          level: level,
          topic: topic,
          language: "Việt Nam",
        );
      } else {
        // Nếu chưa đủ điều kiện fetch thì clear data
        change(null, status: RxStatus.empty());
      }
    });
  }

  void setCourse(String course) {
    selectedCourse.value = course;
  }

  void setLevel(int level) {
    selectedLevel.value = level;
  }

  void setTopic(String? topic) {
    selectedTopic.value = topic;
  }

  Future<bool> fetchQuestions({
    required String course,
    int level = 1,
    String language = "Việt Nam",
    String? topic,
  }) async {
    if (course.isEmpty) {
      change(null, status: RxStatus.error("Bạn chưa chọn khóa học"));
      return false;
    }

    change(null, status: RxStatus.loading());

    final topicToSend = topic ?? "";

    try {
      final response = await _lessonsService.generateLessons(
        course: course,
        topic: topicToSend,
        level: level,
        language: language,
      );

      final dynamic data = jsonDecode(response.body);

      if (data is List) {
        final List<QuestionsModel> questions =
        data.map<QuestionsModel>((e) => QuestionsModel.fromJson(e)).toList();
        change(questions, status: RxStatus.success());
        return true;
      } else if (data is Map && data.containsKey('error')) {
        print('API trả về lỗi: ${data['error']}');
        change(null, status: RxStatus.error(data['error']));
        return false;
      } else {
        print('Dữ liệu trả về không đúng định dạng: $data');
        change(null, status: RxStatus.error("Dữ liệu trả về không đúng định dạng"));
        return false;
      }
    } catch (e) {
      print('Error fetching questions: $e');
      change(null, status: RxStatus.error(e.toString()));
      return false;
    }
  }

  void setLevelAndTopic(int level) {
    selectedLevel.value = level;
    final course = selectedCourse.value;
    final topic = '$course-$level';
    selectedTopic.value = topic;
  }



  Future<void> fetchUnlockedLevel({
    required String userId,
    required String courseName,
  }) async {
    try {
      final response = await Supabase.instance.client
          .from('user_progress')
          .select('unlocked_level')
          .eq('user_id', userId)
          .eq('course_name', courseName)
          .maybeSingle();

      if (response == null) {
        await Supabase.instance.client.from('user_progress').insert({
          'user_id': userId,
          'course_name': courseName,
          'unlocked_level': 1,
        });
        unlockedLevel.value = 1;
      } else {
        unlockedLevel.value = response['unlocked_level'] as int;
      }
    } catch (e) {
      print('Lỗi khi fetch unlocked level: $e');
    }
  }

  Future<void> unlockNextLevel({
    required String userId,
    required String courseName,
    required int newLevel,
  }) async {
    try {
      await Supabase.instance.client
          .from('user_progress')
          .update({'unlocked_level': newLevel})
          .eq('user_id', userId)
          .eq('course_name', courseName);

      unlockedLevel.value = newLevel;
    } catch (e) {
      print('Lỗi khi cập nhật unlocked level: $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
