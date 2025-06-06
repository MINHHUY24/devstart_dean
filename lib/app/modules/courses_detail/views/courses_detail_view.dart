import 'package:devstart/widgets/card_level_course.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/courses_detail_controller.dart';

class CoursesDetailView extends GetView<CoursesDetailController> {
  const CoursesDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CoursesDetailView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
         CardLevelCourse(
           onPressed: (params) {
             controller.fetchQuestions(
               course: params['course'],
               topic: params['topic'],
               level: params['level'],
               language: params['language'],
             );
           },
         )
        ],
      )
    );
  }
}
