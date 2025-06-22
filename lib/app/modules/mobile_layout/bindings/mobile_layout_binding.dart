import 'package:devstart/app/modules/achievement/controllers/achievement_controller.dart';
import 'package:devstart/app/modules/courses/controllers/courses_controller.dart';
import 'package:devstart/app/modules/history/controllers/history_controller.dart';
import 'package:devstart/app/modules/level/controllers/level_controller.dart';
import 'package:devstart/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../notification/controllers/notification_controller.dart';
import '../controllers/mobile_layout_controller.dart';

class MobileLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MobileLayoutController>(
      () => MobileLayoutController(),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    Get.lazyPut<CoursesController>(
          () => CoursesController(),
    );

    Get.put<LevelController>(LevelController(), permanent: true);


    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );

    Get.lazyPut<HistoryController>(
          () => HistoryController(),
    );

    Get.lazyPut<NotificationController>(
          () => NotificationController(),
    );

    Get.lazyPut<AchievementController>(
          () => AchievementController(),
    );



  }
}

