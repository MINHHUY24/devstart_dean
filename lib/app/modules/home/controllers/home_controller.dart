import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../models/course_model.dart';
import '../../../services/course_service.dart';

class HomeController extends GetxController with StateMixin<List<CourseModel>> {
  final RxList<CourseModel> courseList = <CourseModel>[].obs;
  final courseService = CourseService();

  // Getter danh sách các khóa học đã học (progress > 0)
  List<CourseModel> get playedCourses =>
      courseList.where((course) => course.progress > 0).toList();

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  // Hàm gọi dữ liệu khóa học
  Future<void> fetchCourses() async {
    try {
      change(null, status: RxStatus.loading());

      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId == null) {
        throw Exception("User chưa đăng nhập");
      }

      final courses = await courseService.getCoursesWithUserProgress(userId);
      courseList.assignAll(courses);

      if (courses.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(courses, status: RxStatus.success());
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách khóa học: $e');
      change(null, status: RxStatus.error('Failed to fetch courses'));
    }
  }

}

