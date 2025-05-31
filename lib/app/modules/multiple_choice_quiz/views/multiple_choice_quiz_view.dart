import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/multiple_choice_quiz_controller.dart';

class MultipleChoiceQuizView extends GetView<MultipleChoiceQuizController> {
  const MultipleChoiceQuizView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MultipleChoiceQuizView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MultipleChoiceQuizView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
