import 'package:devstart/widgets/cardCourseVertical.dart';
import 'package:devstart/widgets/courseProgressCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../widgets/playTurnController.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final turnController = Get.find<PlayTurnController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // title: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     SvgPicture.network(
        //       Theme.of(context).brightness == Brightness.dark
        //           ? 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//Group%2023.svg'
        //           : 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//logo_light.svg',
        //       width: 55,
        //       height: 55,
        //     ),
        //     const SizedBox(width: 40),
        //     Obx(() {
        //       final turns = turnController.currentTurns.value;
        //       final waiting = turnController.timeUntilNextRestore;
        //
        //       String label;
        //       if (turns > 0) {
        //         label = '$turns';
        //       } else if (waiting != null) {
        //         final minutes = waiting.inMinutes;
        //         final seconds = waiting.inSeconds % 60;
        //         label = 'Chờ ${minutes}p ${seconds}s';
        //       } else {
        //         label = 'Hết lượt';
        //       }
        //
        //       return _buildStatButton(
        //         context,
        //         Icons.favorite,
        //         label,
        //         Theme.of(context).primaryColor,
        //       );
        //     }),
        //
        //
        //     const SizedBox(width: 12),
        //     _buildStatButton(context, Icons.local_fire_department, '10', const Color(0xFFFF6B00)),
        //     const SizedBox(width: 12),
        //     _buildIconButton(context, Icons.notifications_outlined),
        //   ],
        // ),


        // title: Row(
        //   mainAxisSize: MainAxisSize.min,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     SvgPicture.network(
        //       Theme.of(context).brightness == Brightness.dark
        //           ? 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//Group%2023.svg'
        //           : 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//logo_light.svg',
        //       width: 55,
        //       height: 55,
        //     ),
        //     // const SizedBox(width: 180),
        //
        //     // Bỏ nền nút lửa, hiển thị đơn giản
        //     Row(
        //       children: const [
        //         Icon(Icons.local_fire_department, color: Color(0xFFFF6B00), size: 40,),
        //         SizedBox(width: 4),
        //         Text(
        //           '10',
        //           style: TextStyle(
        //             fontSize: 20,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //
        //     // Nếu cần dùng lại Obx() thì thêm lại ở đây
        //     // const SizedBox(width: 12),
        //     // _buildIconButton(context, Icons.notifications_outlined),
        //   ],
        // ),

        title: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          child: SvgPicture.network(
            Theme.of(context).brightness == Brightness.dark
                ? 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//Group%2023.svg'
                : 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//logo_light.svg',
            width: 60,
            height: 60,
          ),
        ),


      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: SingleChildScrollView(
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
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('No courses found', style: TextStyle(color: Colors.white70))),
                  );
                }
                return SizedBox(
                  height: 200,
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

              const SizedBox(height: 16),
              const Text(
                'Resume Your Last Lesson',
                style: TextStyle(
                  color: Color(0xFF00F5D4),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (controller.playedCourses.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "You haven't started any course yet",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.playedCourses.length,
                  itemBuilder: (context, index) {
                    final course = controller.playedCourses[index];
                    return CourseProgressCard(course: course);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                );
              })
            ],
          ),
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
