import 'package:devstart/widgets/card_course.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/custom_search_bar.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: CustomSearchBar(
              controller: searchController,
              onSearch: () {
                final query = searchController.text.trim();
                controller.searchCourses(query);
              },
              onChanged: (query) {
                controller.searchCourses(query);
              },
            ),
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.only(top:16.0, left: 16, right: 16),
        child: Obx(() {
          if (controller.courseList.isEmpty) {
            return Center(child: Text('Không có khoá học nào'));
          }
          return ListView.builder(
            itemCount: controller.courseList.length,
            itemBuilder: (context, index) {
              final course = controller.courseList[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CardCourse(courseModel: course),
              );
            },
          );
        }),
      ),

    );
  }
}
