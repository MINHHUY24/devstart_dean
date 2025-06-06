import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:devstart/models/Questions_model.dart';
import 'package:devstart/app/services/lessons_service.dart';
import 'dart:convert';

class CoursesDetailController extends GetxController with StateMixin<List<QuestionsModel>> {
  //TODO: Implement CoursesDetailController

  final LessonsService _lessonsService = LessonsService();

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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
