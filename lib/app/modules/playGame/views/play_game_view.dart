import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/play_game_controller.dart';

class PlayGameView extends GetView<PlayGameController> {
  PlayGameView({super.key});

  final optionLabels = const ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? const Color(0xFF43D1BD) : Colors.white;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Time Display
                  Obx(() {
                    final int minutes = controller.remainingSeconds ~/ 60;
                    final int seconds = controller.remainingSeconds % 60;

                    final String timeStr =
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

                    return Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF374156),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          timeStr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 12),

                  // Progress bar (theo thời gian)
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF374156), // màu nền (dark)
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Obx(() {
                        double progress = (controller.remainingSeconds / 600.0).clamp(0.0, 1.0);
                        return FractionallySizedBox(
                          alignment: Alignment.centerLeft,  // Thanh thu hẹp từ phải sang trái
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor, // màu xanh lá
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Close button
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xFF1B2231), // màu nền tối
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 12),
                                Text(
                                  'text'.tr,
                                  style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 17),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Cancel button
                                    OutlinedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Theme.of(context).primaryColor),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      ),
                                      child: Text(
                                        'no'.tr,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Yes button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // đóng dialog
                                        Get.back(); // thoát màn hiện tại
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                      ),
                                      child: Text('yes'.tr, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },

                    child: Container(
                      height: 40,
                      width: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF374156),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: iconColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.questions.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
               color: Theme.of(context).primaryColor,
            ),
          );

        }

        final currentIndex = controller.currentIndex.value;
        final currentQuestion = controller.questions[currentIndex];

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Câu hỏi
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'Câu ${currentIndex + 1}/${controller.questions.length}',
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 22,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 8),

                      Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Nếu là câu hỏi tự điền
                      // if (currentQuestion.type == 'fill_in_blank') ...[
                      //   TextField(
                      //     controller: controller.textController,
                      //     style: const TextStyle(color: Colors.white),
                      //     decoration: InputDecoration(
                      //       hintText: 'Nhập câu trả lời...',
                      //       hintStyle: const TextStyle(color: Colors.grey),
                      //       filled: true,
                      //       fillColor: const Color(0xFF374156),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(8),
                      //       ),
                      //     ),
                      //     textInputAction: TextInputAction.done,
                      //     onSubmitted: (value) {
                      //       final answer = value.trim();
                      //       if (answer.isEmpty) return;
                      //       controller.selectAnswer(answer);
                      //       // Không chuyển câu, không clear text
                      //     },
                      //   ),
                      // ]
                      //
                      //
                      // // Nếu là câu hỏi trắc nghiệm
                      // else
                        ...List.generate(
                          currentQuestion.answerBlocks.length,
                              (index) {
                            final answer = currentQuestion.answerBlocks[index];
                            final label = index < optionLabels.length ? optionLabels[index] : '${index + 1}';

                            final selectedAnswer = controller.selectedAnswers[currentIndex];
                            final isSelected = selectedAnswer == answer;
                            final answerStatus = controller.answerResult[currentIndex];

                            Color buttonColor = const Color(0xFF374156);

                            if (isSelected) {
                              final isRevisiting = controller.isRevisitingWrongQuestions;
                              final isJustAnswered = controller.justAnsweredCurrentQuestion.value;

                              if (isRevisiting) {
                                if (answerStatus == true) {
                                  buttonColor = Colors.green;
                                } else if (answerStatus == false && isJustAnswered) {
                                  buttonColor = Colors.red;
                                }
                              } else {
                                if (answerStatus == true) {
                                  buttonColor = Colors.green;
                                } else if (answerStatus == false) {
                                  buttonColor = Colors.red;
                                }
                              }
                            }




                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: buttonColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: () {
                                  controller.selectAnswer(answer);
                                },
                                child: Text(
                                  '$label. $answer',
                                  style: const TextStyle(fontSize: 18, color: Colors.white),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            );
                          },
                        ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
