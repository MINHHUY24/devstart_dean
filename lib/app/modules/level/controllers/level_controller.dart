import 'dart:convert';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/Questions_model.dart';
import '../../../services/lessons_service.dart';

class LevelController extends GetxController with StateMixin<List<QuestionsModel>> {
  //TODO: Implement LevelController
  final LessonsService _lessonsService = LessonsService();
  final unlockedLevel = 1.obs; // Mặc định là level 1


  @override
  void onInit() {
    super.onInit();
    print ('CoursesDetailController initialized');
  }

  Future<void> fetchQuestions({
    String course = "Full-Stack Developer",
    String topic = "Design Partern",
    int level = 1,
    String language = "Việt Nam",
  }) async {
    print('Fetching questions for course: $course, topic: $topic, level: $level, language: $language');
    change(null, status: RxStatus.loading());
    try {
      final response = await _lessonsService.generateLessons(
        course: course,
        topic: topic,
        level: level,
        language: language,
      );
      print('Response status: ${response}');
      final Map<String, dynamic> json = response.body is String
          ? (response.body.isNotEmpty ? jsonDecode(response.body) : {})
          : {};
      final dynamic questionsJson = json['questions'];
      if (questionsJson != null && questionsJson is List) {
        final List<QuestionsModel> questions = questionsJson.map<QuestionsModel>((e) => QuestionsModel.fromJson(e)).toList();
        print('Fetched questions:');
        for (var q in questions) {
          print(q.toJson());
        }
        change(questions, status: RxStatus.success());
      } else {
        change([], status: RxStatus.success());
      }

    } catch (e) {
      print('Error fetching questions: $e');
      change(null, status: RxStatus.error(e.toString()));
    }
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
        // Chưa có record, tạo mới
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
