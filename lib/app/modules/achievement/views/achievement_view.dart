import 'package:devstart/widgets/score.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/achievement_controller.dart';

class AchievementView extends GetView<AchievementController> {
  const AchievementView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AchievementView'),
        centerTitle: true,
      ),
      body: const Center(
      ),
    );
  }
}
