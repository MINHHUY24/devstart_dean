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
  final VoidCallback onPressed;

  static String? _currentSnackbarMessage;
  static bool _isSnackbarShowing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isUnlocked) {
              onPressed(); // Gọi callback (LevelView sẽ xử lý logic và điều hướng)
            } else {
              const message = 'Bạn chưa mở khóa level này';

              if (!_isSnackbarShowing && _currentSnackbarMessage != message) {
                _currentSnackbarMessage = message;
                _isSnackbarShowing = true;

                Get.snackbar(
                  'Thông báo',
                  message,
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: const Color(0xFF374156),
                  colorText: Colors.white,
                  margin: const EdgeInsets.all(10),
                  borderRadius: 8,
                  duration: const Duration(milliseconds: 1500),
                );

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
                top: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                left: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                right: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                bottom: BorderSide(color: Theme.of(context).primaryColor, width: 4),
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

