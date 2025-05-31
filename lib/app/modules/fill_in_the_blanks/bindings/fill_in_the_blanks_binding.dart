import 'package:get/get.dart';

import '../controllers/fill_in_the_blanks_controller.dart';

class FillInTheBlanksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FillInTheBlanksController>(
      () => FillInTheBlanksController(),
    );
  }
}
