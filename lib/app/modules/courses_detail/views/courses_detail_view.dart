import 'package:devstart/widgets/card_level_course.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../models/course_model.dart';
import '../controllers/courses_detail_controller.dart';

class CoursesDetailView extends GetView<CoursesDetailController> {
  CoursesDetailView({super.key});
  final CourseModel courseModel = Get.arguments;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(courseModel.name, style: TextStyle(fontSize: 20)),
          centerTitle: true,
        ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
         // CardLevelCourse(
         //   onPressed: (params) {
         //     controller.fetchQuestions(
         //       course: params['course'],
         //       topic: params['topic'],
         //       level: params['level'],
         //       language: params['language'],
         //     );
         //   },
         // )
        ],
      )
    );
  }
}
