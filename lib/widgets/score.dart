import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/modules/home/controllers/home_controller.dart';
import '../app/modules/level/controllers/level_controller.dart';
import '../app/routes/app_pages.dart';
import '../../../../models/Questions_model.dart';

class Score extends StatefulWidget {
  final double score;
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
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  void initState() {
    super.initState();
    _handleUnlock();
  }

  Future<void> _handleUnlock() async {
    final levelController = Get.find<LevelController>();
    final currentLevel = levelController.selectedLevel.value;
    final course = levelController.selectedCourse.value;
    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId != null && widget.score >= widget.total * 0.6) {
      final nextLevel = currentLevel + 1;

      await levelController.unlockNextLevel(
        userId: userId,
        courseName: course,
        newLevel: nextLevel,
      );
      await levelController.fetchUnlockedLevel(
        userId: userId,
        courseName: course,
      );
      print('Đã mở khóa level $nextLevel cho khóa học $course');
    } else {
      print('Không đủ điểm để mở khóa hoặc thiếu userId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "congratulations".tr,
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
                "${widget.score.toStringAsFixed(1)} / 10.0 points",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final homeController = Get.find<HomeController>();
                  homeController.fetchCourses(); // Gọi lại danh sách course có cập nhật

                  Get.offAllNamed(Routes.MOBILE_LAYOUT);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF374156),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(
                  "home".tr,
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
