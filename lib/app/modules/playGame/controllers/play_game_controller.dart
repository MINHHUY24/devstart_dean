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
  final RxDouble score = 0.0.obs; //
  final TextEditingController textController = TextEditingController();
  final Rx<Duration> remainingTime = Rx(const Duration(minutes: 10));

  final LevelController levelController = Get.find<LevelController>();

  final RxMap<int, bool?> answerResult = <int, bool?>{}.obs;
  final List<QuestionsModel> wrongQuestionsQueue = [];
  bool isRevisitingWrongQuestions = false;
  final RxBool justAnsweredCurrentQuestion = false.obs;

  int originalQuestionCount = 0; //tổng số câu hỏi ban đầu
  final Set<String> scoredQuestions = {}; // theo dõi câu đã được cộng điểm

  int get remainingSeconds => remainingTime.value.inSeconds;
  Timer? _timer;

  final RxMap<int, String> selectedAnswers = <int, String>{}.obs;

  void startTimer() {
    _timer?.cancel();
    remainingTime.value = const Duration(minutes: 10);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds <= 1) {
        timer.cancel();
        finishGame();
      } else {
        remainingTime.value -= const Duration(seconds: 1);
      }
    });
  }

  void finishGame() async {
    _timer?.cancel();

    final total = originalQuestionCount; //tổng số câu ban đầu
    final currentScore = score.value;

    final args = Get.arguments ?? {};
    final course = args['course'] ?? 'Flutter Developer';
    final level = args['level'] ?? 1;

    final userId = Supabase.instance.client.auth.currentUser?.id;

    if (userId != null && currentScore >= (total * 0.6)) {
      final nextLevel = level + 1;

      await levelController.unlockNextLevel(
        userId: userId,
        courseName: course,
        newLevel: nextLevel,
      );

      await levelController.fetchUnlockedLevel(userId: userId, courseName: course);
    }

    Get.offAll(() => Score(
      score: currentScore,
      total: total,
      selectedAnswers: selectedAnswers,
      questions: questions,
    ));
  }

  void nextQuestion() {
    if (questions.isEmpty) return;

    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      textController.clear();
    } else {
      if (!isRevisitingWrongQuestions && wrongQuestionsQueue.isNotEmpty) {
        isRevisitingWrongQuestions = true;
        questions.assignAll(wrongQuestionsQueue);
        wrongQuestionsQueue.clear();
        currentIndex.value = 0;
        textController.clear();
      } else {
        finishGame();
      }
    }
  }

  void setQuestions(List<QuestionsModel> newQuestions) {
    final shuffledQuestions = newQuestions.map<QuestionsModel>((q) {

      final shuffledAnswers = List<String>.from(q.answerBlocks)..shuffle();

      // Đáp án đúng từ API (chuẩn hóa viết thường, loại bỏ khoảng trắng thừa)
      final correctNormalized = q.correctAnswer.trim().toLowerCase();

      // Tìm lại đáp án đúng sau khi shuffle
      final matchedAnswer = shuffledAnswers.firstWhereOrNull(
            (ans) => ans.trim().toLowerCase() == correctNormalized,
      );

      if (matchedAnswer == null) {
        print('Không tìm thấy đáp án đúng sau khi shuffle: ${q.correctAnswer}');
      }

      return q.copyWith(
        answerBlocks: shuffledAnswers,
        correctAnswer: matchedAnswer ?? q.correctAnswer, // fallback an toàn
      );
    }).toList();

    questions.assignAll(shuffledQuestions);
    originalQuestionCount = shuffledQuestions.length;
    currentIndex.value = 0;
    score.value = 0.0;
    selectedAnswers.clear();
    textController.clear();
    answerResult.clear();
    wrongQuestionsQueue.clear();
    isRevisitingWrongQuestions = false;
    scoredQuestions.clear();

    startTimer();
  }


  void selectAnswer(String userAnswer) {
    final index = currentIndex.value;
    final currentQuestion = questions[index];
    final correctAnswer = currentQuestion.correctAnswer.trim().toLowerCase();
    final userAnswerClean = userAnswer.trim().toLowerCase();
    final isCorrect = userAnswerClean == correctAnswer;

    selectedAnswers[index] = userAnswer;
    answerResult[index] = isCorrect;
    justAnsweredCurrentQuestion.value = true;

    // Nếu sai ở lượt đầu → cho làm lại sau
    if (!isCorrect && !isRevisitingWrongQuestions) {
      wrongQuestionsQueue.add(currentQuestion);
    }

    // Chỉ cộng điểm nếu chưa được cộng
    final questionKey = currentQuestion.question;
    if (isCorrect && !scoredQuestions.contains(questionKey)) {
      final pointPerQuestion = 10.0 / originalQuestionCount;
      score.value += pointPerQuestion;
      scoredQuestions.add(questionKey);
    }

    Future.delayed(const Duration(seconds: 1), () {
      justAnsweredCurrentQuestion.value = false;
      nextQuestion();
    });
  }

  void previousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      textController.clear();
    }
  }

  void resetGame() {
    currentIndex.value = 0;
    score.value = 0.0;
    selectedAnswers.clear();
    textController.clear();
  }

  @override
  void onInit() {
    super.onInit();
    _initGame();
  }

  void _initGame() async {
    final args = Get.arguments ?? {};
    final course = args['course'] ?? 'Flutter Developer';
    final topic = args['topic'] ?? 'Flutter Developer-1';
    final level = args['level'] ?? 1;

    final levelController = Get.find<LevelController>();

    //Nếu câu hỏi đã được tải từ trước, không gọi lại API
    if (levelController.state != null && levelController.state!.isNotEmpty) {
      setQuestions(levelController.state!);
    } else {
      final success = await levelController.fetchQuestions(
        course: course,
        level: level,
        topic: topic,
        language: Get.locale?.languageCode == 'vi' ? 'Việt Nam' : 'English',
      );

      if (success) {
        setQuestions(levelController.state ?? []);
      } else {
        Get.snackbar('Lỗi', 'Không thể tải câu hỏi');
        Get.back();
      }
    }
  }


  @override
  void onClose() {
    _timer?.cancel();
    textController.dispose();
    super.onClose();
  }
}
