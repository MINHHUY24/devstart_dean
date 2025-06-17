import 'package:get/get.dart';

import '../../../../models/course_model.dart';
import '../../../services/course_service.dart';

class CoursesController extends GetxController with StateMixin<List<CourseModel>> {
  final isLoading = false.obs;
  final courseList = RxList<CourseModel>([]);
  final courseService = CourseService();

  // Lưu danh sách gốc để filter khi search
  final List<CourseModel> _allCourses = [];

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    change(null, status: RxStatus.loading());
    print('Fetching courses...');
    try {
      final courses = await courseService.getCourses();
      print('Fetched courses: $courses');
      _allCourses.clear();
      _allCourses.addAll(courses); // Lưu danh sách gốc
      courseList.assignAll(courses); // Gán vào danh sách đang hiển thị
      change(courseList, status: RxStatus.success());
    } catch (e) {
      print('Fetch error: $e');
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void searchCourses(String keyword) {
    if (keyword.isEmpty) {
      courseList.assignAll(_allCourses);
    } else {
      final filtered = _allCourses.where((course) =>
          course.name.toLowerCase().contains(keyword.toLowerCase())
      ).toList();
      courseList.assignAll(filtered);
    }
  }

  Future<void> addCourse(CourseModel course) async {
    try {
      final newCourse = await courseService.addCourse(course);
      _allCourses.add(newCourse);
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
        final allIndex = _allCourses.indexWhere((course) => course.id == id);
        if (allIndex != -1) _allCourses[allIndex] = updatedCourse;
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
      _allCourses.removeWhere((course) => course.id == id);
      Get.snackbar('Thành công', 'Đã xoá khoá học');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể xoá');
    }
  }
}
