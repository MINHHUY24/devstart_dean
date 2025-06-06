
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
}