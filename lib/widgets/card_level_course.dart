import 'package:devstart/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CardLevelCourse extends StatelessWidget {
  const CardLevelCourse({
    super.key,
    required this.level,
    required this.isUnlocked,
    required this.onPressed,
  });

  final int level;
  final bool isUnlocked;
  final ValueChanged<Map<String, dynamic>> onPressed;

  // Biến tĩnh để lưu message đang hiển thị, tránh show lại nếu giống nhau
  static String? _currentSnackbarMessage;

  // Biến cờ để biết snackbar đang hiển thị
  static bool _isSnackbarShowing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isUnlocked) {
              // // Dùng Get.to để chuyển sang GameStartPage
              Get.toNamed(Routes.PLAY_GAME);


              onPressed({
                'course': "Full-Stack Developer",
                'level': level,
                'language': "Việt Nam",
                'topic': "Design Pattern",
              });
            } else {
              const message = 'Bạn chưa mở khóa level này';

              if (!_isSnackbarShowing && _currentSnackbarMessage != message) {
                _currentSnackbarMessage = message;
                _isSnackbarShowing = true;

                Get.snackbar(
                  'Thông báo',
                  message,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Color(0xFF374156),
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: const Duration(milliseconds: 1500),
                );

                // Sau 3 giây (khi snackbar tự ẩn), reset cờ và message
                Future.delayed(const Duration(milliseconds: 1500), () {
                  _isSnackbarShowing = false;
                  _currentSnackbarMessage = null;
                });
              }
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF374156),
              borderRadius: BorderRadius.circular(10),
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                left: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                right: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 4,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isUnlocked)
                  Text(
                    "Level $level",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  )
                else
                  Icon(
                    Icons.lock_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
