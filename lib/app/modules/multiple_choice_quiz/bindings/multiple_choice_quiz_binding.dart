import 'package:get/get.dart';

import '../controllers/multiple_choice_quiz_controller.dart';

class MultipleChoiceQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultipleChoiceQuizController>(
      () => MultipleChoiceQuizController(),
    );
  }
}
