import 'package:devstart/widgets/cardCourseVertical.dart'; // Đảm bảo bạn có widget này
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.network(
              Theme.of(context).brightness == Brightness.dark
                  ? 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//Group%2023.svg'
                  : 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//logo_light.svg',
              width: 55,
              height: 55,
            ),
            const SizedBox(width: 40),
            _buildStatButton(context, Icons.favorite, '10', Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            _buildStatButton(context, Icons.local_fire_department, '10', const Color(0xFFFF6B00)),
            const SizedBox(width: 12),
            _buildIconButton(context, Icons.notifications_outlined),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What Will You Learn Today?',
              style: TextStyle(
                color: Color(0xFF00F5D4),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              if (controller.courseList.isEmpty) {
                return const Center(child: Text('No courses found'));
              }
              return SizedBox(
                height: 200, // Chiều cao của CardCourseVertical
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.courseList.length,
                  itemBuilder: (context, index) {
                    final course = controller.courseList[index];
                    return CardCourseVertical(courseModel: course);
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
  Widget _buildStatButton(BuildContext context, IconData icon, String label, Color iconColor) {
    return Flexible(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {},
          child: Ink(
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF374156),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildIconButton(BuildContext context, IconData icon) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {},
        child: Ink(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF374156),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
