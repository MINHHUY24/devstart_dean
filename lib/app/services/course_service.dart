
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/course_model.dart';

class CourseService {
  final _client = Supabase.instance.client;

  Future<List<CourseModel>> getCourses() async {
    final response = await _client.from('courses').select().order('name', ascending: true);
    return (response as List).map((e) => CourseModel.fromJson(e)).toList();
  }

  Future<CourseModel> addCourse(CourseModel course) async {
    final response = await _client.from('courses').insert(course.toJson()).select().single();
    return CourseModel.fromJson(response);
  }

  Future<void> updateCourse(String id, CourseModel course) async {
    await _client.from('courses').update(course.toJson()).eq('id', id);
  }

  Future<void> deleteCourse(String id) async {
    await _client.from('courses').delete().eq('id', id);
  }



  Future<List<CourseModel>> getCoursesWithUserProgress(String userId) async {
    // Lấy tất cả course từ bảng courses
    final coursesResponse = await _client.from('courses').select();
    final List courses = coursesResponse;

    // Lấy progress của user từ bảng user_progress
    final userProgressResponse = await _client
        .from('user_progress')
        .select('course_name, progress')
        .eq('user_id', userId);
    final List userProgress = userProgressResponse;

    // Map tên khóa học -> tiến độ
    final Map<String, int> progressMap = {
      for (var item in userProgress)
        item['course_name']: item['progress'] ?? 0,
    };

    // Gộp dữ liệu vào CourseModel
    return courses.map<CourseModel>((course) {
      return CourseModel(
        id: course['id'],
        name: course['name'],
        description: course['description'] ?? '',
        imageUrl: course['imageUrl'] ?? '',
        progress: progressMap[course['name']] ?? 0,
        status: course['status'] ?? '',
      );

    }).toList();
  }

}

