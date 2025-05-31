import 'package:get/get.dart';

import '../controllers/courses_detail_controller.dart';

class CoursesDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesDetailController>(
      () => CoursesDetailController(),
    );
  }
}
