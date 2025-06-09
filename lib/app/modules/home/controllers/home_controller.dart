import 'package:get/get.dart';
import '../../../../models/course_model.dart';
import '../../../services/course_service.dart';

class HomeController extends GetxController with StateMixin<List<CourseModel>> {
  final RxList<CourseModel> courseList = <CourseModel>[].obs;
  final courseService = CourseService();


  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  // Hàm gọi dữ liệu khóa học
  Future<void> fetchCourses() async {
    try {
      final courses = await courseService.getCourses();
      courseList.assignAll(courses);
    } catch (e) {
      print('Lỗi khi lấy danh sách khóa học: $e');
    }
  }
}
