import 'package:get/get.dart';
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
      change(null, status: RxStatus.loading()); // Bắt đầu loading

      final courses = await courseService.getCourses();
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

