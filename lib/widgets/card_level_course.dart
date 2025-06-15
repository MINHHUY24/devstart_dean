import 'package:devstart/widgets/playTurnController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardLevelCourse extends StatelessWidget {
  const CardLevelCourse({
    super.key,
    required this.level,
    required this.isUnlocked,
    required this.onPressed,
    this.progress = 0, // thêm progress mặc định
  });

  final int level;
  final bool isUnlocked;
  final VoidCallback onPressed;
  final int progress;

  static String? _currentSnackbarMessage;
  static bool _isSnackbarShowing = false;

  @override
  Widget build(BuildContext context) {
    final playTurnController = Get.find<PlayTurnController>();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isUnlocked) {
              if (playTurnController.currentTurns.value > 0) {
                playTurnController.useTurn();
                onPressed();
              } else {
                final time = playTurnController.timeUntilNextRestore;
                final message = time == null
                    ? 'Bạn đã hết lượt chơi. Vui lòng đợi để hồi lượt.'
                    : 'Hết lượt. Lượt tiếp theo sau: ${time.inMinutes} phút';

                _showSnackbar(message, durationMs: 2000);
              }
            } else {
              _showSnackbar('Bạn chưa mở khóa level này', durationMs: 1500);
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
                if (isUnlocked) ...[
                  Text(
                    "Level $level",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                ] else
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

  void _showSnackbar(String message, {int durationMs = 2000}) {
    if (!_isSnackbarShowing || _currentSnackbarMessage != message) {
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
        duration: Duration(milliseconds: durationMs),
      );

      Future.delayed(Duration(milliseconds: durationMs), () {
        _isSnackbarShowing = false;
        _currentSnackbarMessage = null;
      });
    }
  }
}
