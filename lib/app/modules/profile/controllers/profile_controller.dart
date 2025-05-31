import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  final userName = 'Nguyễn Văn A'.obs;
  final userEmail = 'nguyenvana@example.com'.obs;
  final userAvatar = 'https://example.com/avatar.png'.obs;

  final isDarkMode = false.obs;
  final selectedLanguage = 'en'.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeLanguage(String langCode) {
    selectedLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
  }

  void logout() {
    // Thực hiện xóa dữ liệu người dùng và điều hướng đến màn hình đăng nhập
    // Ví dụ:
    // await AuthService.logout();
    Get.offAllNamed('/login');
  }

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

}
