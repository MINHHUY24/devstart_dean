import 'package:get/get.dart';

import '../../../services/notification_service.dart';

class NotificationController extends GetxController {
  //TODO: Implement NotificationController
  var isNotificationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Load trạng thái từ SharedPreferences
    NotificationSettings.isNotificationEnabled().then((enabled) {
      isNotificationEnabled.value = enabled;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void toggleNotification() async {
    isNotificationEnabled.value = !isNotificationEnabled.value;
    await NotificationService.toggleNotifications(isNotificationEnabled.value);
  }
}
