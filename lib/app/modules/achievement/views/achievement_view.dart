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
        child: Text(
          'AchievementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
