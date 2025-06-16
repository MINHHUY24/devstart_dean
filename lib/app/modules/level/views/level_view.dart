import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/course_model.dart';
import '../../../../widgets/card_level_course.dart';
import '../../playGame/controllers/play_game_controller.dart';
import '../controllers/level_controller.dart';

class LevelView extends StatefulWidget {
  LevelView({Key? key}) : super(key: key);
  final CourseModel courseModel = Get.arguments;

  @override
  State<LevelView> createState() => _LevelViewState();
}

class _LevelViewState extends State<LevelView> {
  final LevelController controller = Get.find();

  @override
  void initState() {
    super.initState();

    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id;

    // Chỉ gọi 1 lần duy nhất ở đây khi widget khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.setCourse(widget.courseModel.name);
      if (userId != null) {
        controller.fetchUnlockedLevel(
          userId: userId,
          courseName: widget.courseModel.name,
        );
      } else {
        Get.snackbar('Thông báo', 'Bạn cần đăng nhập để xem khóa học');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.courseModel.name,
          style: const TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),

          );
        }

        final unlocked = controller.unlockedLevel.value;
        final course = controller.selectedCourse.value;
        final topic = controller.selectedTopic.value;
        print('Selected topic: $topic');

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final levelNum = index + 1;
              final isUnlocked = levelNum <= unlocked;

              return CardLevelCourse(
                level: levelNum,
                isUnlocked: isUnlocked,
                onPressed: () {
                  controller.setLevelAndTopic(levelNum);

                  final course = controller.selectedCourse.value;
                  final topic = controller.selectedTopic.value ?? '';

                  print('Pressed level $levelNum with topic: $topic');

                  Get.toNamed(
                    '/play-game',
                    arguments: {
                      'course': course,
                      'topic': topic,
                      'level': levelNum,
                    },
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
