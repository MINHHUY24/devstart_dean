import 'package:http/http.dart' as http;

class LessonsService {
  Future<http.Response> generateLessons({required String course, required String topic, required int level, required String language}) {
    return http.post(Uri.parse('http://localhost:3000'),body:{
      'course': course,
      'topic': topic,
      'level': level.toString(),
      'language': language,
    });
  }
}