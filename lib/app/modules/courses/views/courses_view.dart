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
                print('Searching for: $query');
                // controller.search(query); // nếu bạn có hàm search
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardCourse(),
          ],
        ),
      ),
    );
  }
}
