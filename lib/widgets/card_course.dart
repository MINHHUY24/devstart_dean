import 'package:devstart/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/level/controllers/level_controller.dart';
import '../app/routes/app_pages.dart';

class CardCourse extends StatelessWidget {
  const CardCourse({super.key, required this.courseModel});

  final CourseModel courseModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 6),
      // khoảng cách nhẹ giữa các card
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: SizedBox(
                  width: 110,
                  child: Image.network(
                    courseModel.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 12,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseModel.name,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        courseModel.description,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Center( // Đây là điểm mấu chốt để căn giữa nút Play
                  child: SizedBox(
                    width: 70,
                    height: 38,
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {
                          final levelController = Get.find<LevelController>();
                          levelController.setCourse(courseModel.name);
                          Get.toNamed(Routes.LEVEL, arguments: courseModel);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              'Play',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
