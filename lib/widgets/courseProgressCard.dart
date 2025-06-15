import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/course_model.dart';

class CourseProgressCard extends StatelessWidget {
  final CourseModel course;
  const CourseProgressCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              course.imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Updated today',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 5.0,
              percent: course.progress / 100.0,
              center: Text(
                "${course.progress}%",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              progressColor: const Color(0xFF00F5D4),
              backgroundColor: Colors.grey.shade800,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
        ],
      ),
    );
  }
}
