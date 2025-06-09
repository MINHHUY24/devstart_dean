import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../models/Questions_model.dart';
import '../../../../widgets/score.dart';
import '../../level/controllers/level_controller.dart';

class PlayGameController extends GetxController {
  final RxList<QuestionsModel> questions = <QuestionsModel>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxInt score = 0.obs;
  final TextEditingController textController = TextEditingController();
  final Rx<Duration> remainingTime = Rx(const Duration(minutes: 10));

  final LevelController levelController = Get.find<LevelController>();




  int get remainingSeconds => remainingTime.value.inSeconds;

  Timer? _timer;

  // Lưu đáp án người dùng đã chọn: key = index câu hỏi, value = đáp án
  final RxMap<int, String> selectedAnswers = <int, String>{}.obs;

  void startTimer() {
    _timer?.cancel();
    remainingTime.value = const Duration(minutes: 10);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds <= 1) {
        timer.cancel();
        // Hết giờ, xử lý như hoàn thành game
        finishGame();
      } else {
        remainingTime.value -= const Duration(seconds: 1);
      }
    });
  }

  void finishGame() async {
    _timer?.cancel();

    final total = questions.length;
    final currentScore = score.value;

    final args = Get.arguments ?? {};
    final course = args['course'] ?? 'Flutter Developer';
    final level = args['level'] ?? 1;

    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId != null && currentScore >= (total * 0.6).round()) {
      final nextLevel = level + 1;

      await levelController.unlockNextLevel(
        userId: userId,
        courseName: course,
        newLevel: nextLevel,
      );

      // Optional: cập nhật level hiện tại trên UI nếu bạn cần
      await levelController.fetchUnlockedLevel(userId: userId, courseName: course);
    }

    // Điều hướng đến màn hình kết quả
    Get.offAll(
          () => Score(
        score: currentScore,
        total: total,
        selectedAnswers: selectedAnswers,
        questions: questions,
      ),
    );
  }


  void nextQuestion() {
    if (questions.isEmpty) return;

    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      textController.clear();
    } else {
      _timer?.cancel();
      Get.offAll(
        () => Score(
          score: score.value,
          total: questions.length,
          selectedAnswers: selectedAnswers,
          questions: questions,
        ),
      );
    }
  }

  void setQuestions(List<QuestionsModel> newQuestions) {
    questions.assignAll(newQuestions);
    currentIndex.value = 0;
    score.value = 0;
    selectedAnswers.clear();
    textController.clear();

    startTimer();
  }

  // Gọi khi người chơi chọn đáp án
  void selectAnswer(String userAnswer) {
    final index = currentIndex.value;

    // Nếu câu này chưa chọn và trả lời đúng thì cộng điểm
    if (!selectedAnswers.containsKey(index)) {
      final correctAnswer = questions[index].correctAnswer;
      if (userAnswer.trim().toLowerCase() ==
          correctAnswer.trim().toLowerCase()) {
        score.value++;
      }
    }

    selectedAnswers[index] = userAnswer;
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      textController.clear();
    }
  }

  void resetGame() {
    currentIndex.value = 0;
    score.value = 0;
    selectedAnswers.clear();
    textController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _initGame();
  }

  // void _initGame() async {
  //   final args = Get.arguments;
  //
  //   final course = args['course'];
  //   final topic = args['topic'];
  //   final level = args['level'];
  //
  //   final levelController = Get.find<LevelController>();
  //
  //   final success = await levelController.fetchQuestions(
  //     course: course,
  //     topic: topic,
  //     level: level,
  //     language: 'Việt Nam',
  //   );
  //
  //   if (success) {
  //     setQuestions(levelController.state ?? []);
  //   } else {
  //     Get.snackbar('Lỗi', 'Không thể tải câu hỏi');
  //     Get.back();
  //   }
  // }

  void _initGame() async {
    final args = Get.arguments ?? {};

    final course = args['course'] ?? 'Flutter Developer';
    final topic = args['topic'] ?? 'Flutter Developer-1';
    final level = args['level'] ?? 1;

    final levelController = Get.find<LevelController>();

    // Gọi hàm mock để lấy dữ liệu mẫu test
    final success = await levelController.fetchQuestionsMock();

    if (success) {
      setQuestions(levelController.state ?? []);
    } else {
      Get.snackbar('Lỗi', 'Không thể tải câu hỏi mẫu');
      Get.back();
    }
  }




  @override
  void onClose() {
    _timer?.cancel();
    textController.dispose();
    super.onClose();
  }
}
