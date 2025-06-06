import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/course_model.dart';
import '../../../../widgets/card_level_course.dart';
import '../controllers/level_controller.dart';

class LevelView extends GetView<LevelController> {
  LevelView({super.key});
  final CourseModel courseModel = Get.arguments;
  final LevelController controller = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    // Lấy userId tự động từ Supabase Auth
    final user = Supabase.instance.client.auth.currentUser;
    final userId = user?.id;

    if (userId != null) {
      controller.fetchUnlockedLevel(
        userId: userId,
        courseName: courseModel.name,
      );
    } else {
      // Nếu chưa đăng nhập, có thể show snackbar hoặc chuyển trang đăng nhập
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar('Thông báo', 'Bạn cần đăng nhập để xem khóa học');
        // Hoặc Get.offAllNamed('/login');
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(courseModel.name, style: TextStyle(fontSize: 20)),
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
          itemCount: 10,
          itemBuilder: (context, index) {
            final levelNum = index + 1;
            final isUnlocked = levelNum <= controller.unlockedLevel.value;

            return CardLevelCourse(
              level: levelNum,
              isUnlocked: isUnlocked,
              onPressed: (params) {
                if (!isUnlocked) {
                  Get.snackbar("Chưa mở khóa", "Hãy hoàn thành level trước");
                  return;
                }

                controller.fetchQuestions(
                  course: params['course'],
                  topic: params['topic'],
                  level: params['level'],
                  language: params['language'],
                );

                // TODO: Nếu muốn chuyển trang sau khi fetch, thêm tại đây
              },
            );
          },
        ),
    );
  }
}
