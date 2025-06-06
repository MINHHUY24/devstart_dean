import 'package:get/get.dart';

import '../../../../models/course_model.dart';
import '../../../services/course_service.dart';

class CoursesController extends GetxController with StateMixin<List<CourseModel>> {
  //TODO: Implement CoursesController

  final isLoading = false.obs;
  final courseList = RxList<CourseModel>([]);
  final courseService = CourseService();

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchCourses() async {
    change(null, status: RxStatus.loading());
    print('Fetching courses...');
    try {
      final courses = await courseService.getCourses();
      print('Fetched courses: $courses');
      courseList.assignAll(courses);
      change(courseList, status: RxStatus.success());
    } catch (e) {
      print('Fetch error: $e');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addCourse(CourseModel course) async {
    try {
      final newCourse = await courseService.addCourse(course);
      courseList.add(newCourse);
      courseList.refresh();
      Get.snackbar('Thành công', 'Đã thêm khoá học mới');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể thêm khoá học');
    }
  }

  Future<void> updateCourse(String id, CourseModel updatedCourse) async {
    try {
      await courseService.updateCourse(id, updatedCourse);
      final index = courseList.indexWhere((course) => course.id == id);
      if (index != -1) {
        courseList[index] = updatedCourse;
        courseList.refresh();
      }
      Get.snackbar('Thành công', 'Đã cập nhật khoá học');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể cập nhật');
    }
  }

  Future<void> deleteCourse(String id) async {
    try {
      await courseService.deleteCourse(id);
      courseList.removeWhere((course) => course.id == id);
      Get.snackbar('Thành công', 'Đã xoá khoá học');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể xoá');
    }
  }
}
