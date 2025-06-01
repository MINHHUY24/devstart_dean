import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NotificationView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  controller.toggleNotification();
                },
                child: Ink(
                  height: 70,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).inputDecorationTheme.fillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Thông báo',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.toggleNotification,
                          child: Container(
                            width: 60,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  controller.isNotificationEnabled.value
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[400],
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  alignment:
                                      controller.isNotificationEnabled.value
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 3,
                                    ),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
