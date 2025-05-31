import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/courses_detail_controller.dart';

class CoursesDetailView extends GetView<CoursesDetailController> {
  const CoursesDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoursesDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CoursesDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
