import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../login/controllers/login_controller.dart';
import '../../mobile_layout/controllers/mobile_layout_controller.dart';

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

  static Future<void> logout() async {
    try {
      // Đăng xuất Google (nếu đã dùng Google để đăng nhập)
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      // Đăng xuất Supabase
      await Supabase.instance.client.auth.signOut();

      // Xóa các controller liên quan (nếu muốn)
      Get.delete<LoginController>();
      Get.delete<ProfileController>();
      Get.delete<MobileLayoutController>();

      // Điều hướng về màn hình đăng nhập
      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout failed: $e');
    }
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
