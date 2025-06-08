import 'dart:convert';
import 'package:http/http.dart' as http;

class LessonsService {
  Future<http.Response> generateLessons({
    required String course,
    required String topic,
    required int level,
    required String language,
  }) {
    final url = Uri.parse('http://localhost:3000/generate-questions');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'course': course,
      'topic': topic,
      'level': level,
      'language': language,
    });

    return http.post(url, headers: headers, body: body);
  }
}
