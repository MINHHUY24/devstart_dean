import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/modules/level/controllers/level_controller.dart';
import '../app/routes/app_pages.dart';
import '../../../../models/Questions_model.dart';

class Score extends StatelessWidget {
  final int score;
  final int total;
  final Map<int, String> selectedAnswers;
  final List<QuestionsModel> questions;

  const Score({
    super.key,
    required this.score,
    required this.total,
    required this.selectedAnswers,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final levelController = Get.find<LevelController>();
    final currentLevel = levelController.selectedLevel.value;
    final course = levelController.selectedCourse.value;
    final userId = Supabase.instance.client.auth.currentUser?.id;

    // Nếu đạt đủ điểm, mở khóa level tiếp theo
    if (userId != null && score >= (total * 0.6).round()) {
      final nextLevel = currentLevel + 1;
      levelController.unlockNextLevel(
        userId: userId,
        courseName: course,
        newLevel: nextLevel,
      ).then((_) {
        // Gọi lại để cập nhật giao diện
        levelController.fetchUnlockedLevel(userId: userId, courseName: course);
      });
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              CircleAvatar(
                radius: 130,
                backgroundColor: const Color(0xFF41BFAD),
                child: Image.network(
                  'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images/Cup.png',
                  width: 600,
                  height: 600,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "$score / $total",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${(score / total * 10).toStringAsFixed(1)} points",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.ACHIEVEMENT, // hoặc route nào bạn dùng để xem đáp án
                    arguments: {
                      "selectedAnswers": selectedAnswers,
                      "questions": questions,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3DDACF),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  "View answers",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(Routes.MOBILE_LAYOUT);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF374156),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
