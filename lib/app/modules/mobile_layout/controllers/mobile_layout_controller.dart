import 'package:get/get.dart';

import '../../courses/views/courses_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class MobileLayoutController extends GetxController {
  //TODO: Implement MobileLayoutController

  //TODO: Implement MobileLayoutController
  var selectedIndex = 0.obs;
  final pages = [
    HomeView(),
    CoursesView(),
    ProfileView(),
  ];
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }

}
