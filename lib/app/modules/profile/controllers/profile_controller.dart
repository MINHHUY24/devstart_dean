import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../theme/theme.dart';
import '../../login/controllers/login_controller.dart';
import '../../mobile_layout/controllers/mobile_layout_controller.dart';

class ProfileController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userAvatar = ''.obs;

  final selectedLanguage = 'en'.obs;

  late SharedPreferences prefs;

  final ThemeController themeController = Get.find<ThemeController>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      // Lấy user Google nếu đã đăng nhập
      final googleUser = await googleSignIn.signInSilently();
      if (googleUser != null) {
        userName.value = googleUser.displayName ?? 'No name';
        userEmail.value = googleUser.email;
        userAvatar.value = googleUser.photoUrl ?? '';
      } else {
        // Hoặc lấy user từ Supabase nếu bạn lưu thông tin user ở đó
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
          userEmail.value = user.email ?? '';
          userName.value = user.userMetadata?['full_name'] ?? 'No name';
          userAvatar.value = user.userMetadata?['avatar_url'] ?? '';
        }
      }
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  Future<void> _loadLanguage() async {
    prefs = await SharedPreferences.getInstance();
    final lang = prefs.getString('language');
    if (lang != null) {
      selectedLanguage.value = lang;
      Get.updateLocale(Locale(lang));
    }
  }

  void toggleTheme() {
    final isDark = themeController.themeMode.value == ThemeMode.dark;
    themeController.toggleTheme(!isDark);
  }

  void changeLanguage(String langCode) {
    selectedLanguage.value = langCode;
    Get.updateLocale(Locale(langCode));
    prefs.setString('language', langCode);
  }

  static Future<void> logout() async {
    try {
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      await Supabase.instance.client.auth.signOut();

      Get.delete<LoginController>();
      Get.delete<ProfileController>();
      Get.delete<MobileLayoutController>();

      Get.offAllNamed('/login');
    } catch (e) {
      print('Logout failed: $e');
    }
  }
}
