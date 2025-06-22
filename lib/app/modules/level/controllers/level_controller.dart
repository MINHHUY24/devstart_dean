import 'dart:convert';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/Questions_model.dart';
import '../../../services/lessons_service.dart';
import '../../home/controllers/home_controller.dart';

class LevelController extends GetxController with StateMixin<List<QuestionsModel>> {
  final LessonsService _lessonsService = LessonsService();
  final unlockedLevel = 1.obs;

  final selectedCourse = ''.obs;
  final selectedLevel = 1.obs;
  final selectedTopic = RxnString(); // nullable
  final completedLevels = <int, bool>{}.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    print('LevelController initialized');
  }

  //Hàm duy nhất bạn gọi từ UI khi chọn course & level
  void setCourseAndLevel(String course, int level) {
    selectedCourse.value = course;
    selectedLevel.value = level;
    final topic = '$course-$level';
    selectedTopic.value = topic;

    print('setCourseAndLevel gọi fetch với topic: $topic');

    //Gọi fetch tại đây
    fetchQuestions(
      course: course,
      level: level,
      topic: topic,
      language: Get.locale?.languageCode == 'vi' ? 'Việt Nam' : 'English',

    );
  }


  void setCourse(String course) => selectedCourse.value = course;
  void setLevel(int level) => selectedLevel.value = level;
  void setTopic(String? topic) => selectedTopic.value = topic;

  void setLevelAndTopic(int level) {
    selectedLevel.value = level;
    final course = selectedCourse.value;
    selectedTopic.value = '$course-$level';
  }

  Future<bool> fetchQuestions({
    required String course,
    int level = 1,
    String? topic,
    required String language,
  }) async {
    if (course.isEmpty) {
      change(null, status: RxStatus.error("Bạn chưa chọn khóa học"));
      return false;
    }

    change(null, status: RxStatus.loading());
    final topicToSend = topic ?? "";
    final language = Get.locale?.languageCode == 'vi' ? 'Việt Nam' : 'English';

    try {
      final response = await _lessonsService.generateLessons(
        course: course,
        topic: topicToSend,
        level: level,
        language: language,
      );

      final dynamic data = jsonDecode(response.body);

      if (data is List) {
        final questions = data.map<QuestionsModel>((e) => QuestionsModel.fromJson(e)).toList();
        change(questions, status: RxStatus.success());
        return true;
      } else if (data is Map && data.containsKey('error')) {
        change(null, status: RxStatus.error(data['error']));
        return false;
      } else {
        change(null, status: RxStatus.error("Dữ liệu trả về không đúng định dạng"));
        return false;
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      return false;
    }
}

  Future<void> fetchUnlockedLevel({
    required String userId,
    required String courseName,
  }) async {
    isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> unlockNextLevel({
    required String userId,
    required String courseName,
    required int newLevel,
  }) async {
    const int maxLevel = 10;

    try {
      if (newLevel <= unlockedLevel.value) {
        print('Level $newLevel đã được mở hoặc nhỏ hơn. Không cần cập nhật.');
        return;
      }

      final newProgress = ((newLevel - 1) / maxLevel * 100).round();

      final response = await Supabase.instance.client
          .from('user_progress')
          .update({
        'unlocked_level': newLevel,
        'progress': newProgress,
      })
          .eq('user_id', userId)
          .eq('course_name', courseName);

      if (response != null) {
        unlockedLevel.value = newLevel;
        print('Cập nhật unlocked_level = $newLevel, progress = $newProgress');
      } else {
        print('Cập nhật không thành công');
      }
    } catch (e) {
      print('Lỗi khi cập nhật unlocked level: $e');
    }
  }

  Future<void> onLevelCompleted() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final course = selectedCourse.value;
    final nextLevel = selectedLevel.value + 1;

    if (userId == null || course.isEmpty) {
      print('Thiếu userId hoặc course');
      return;
    }

    await unlockNextLevel(
      userId: userId,
      courseName: course,
      newLevel: nextLevel,
    );

    await fetchUnlockedLevel(userId: userId, courseName: course);

    Get.find<HomeController>().fetchCourses();
    // setCourseAndLevel(course, nextLevel); // Nếu muốn tự động chuyển level tiếp theo
  }
}
