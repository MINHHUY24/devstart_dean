import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../theme/theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({super.key});

  Widget myItemWidget({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    double? width, // cho phép truyền width bên ngoài, nếu null thì tự co giãn
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        width: width, // nếu null thì không cố định width
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 25,
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).textTheme.labelLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final themeController = Get.find<ThemeController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 45,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
          child: Text(
            'settings'.tr,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 22.0, left: 16, right: 16),
        child: Center(
          child: Column(
            children: [
              InkWell(
                // borderRadius: BorderRadius.circular(12), // để splash bo góc
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  print('Tapped profile info');
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
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Obx(
                          () => CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                profileController.userAvatar.value.isNotEmpty
                                    ? NetworkImage(
                                      profileController.userAvatar.value,
                                    )
                                    : NetworkImage(
                                      'https://avatar.iran.liara.run/public/28',
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Obx(
                          () => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              profileController.userName.value.isNotEmpty
                                  ? profileController.userName.value
                                  : 'No name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            subtitle: Text(
                              profileController.userEmail.value.isNotEmpty
                                  ? profileController.userEmail.value
                                  : 'No email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // const SizedBox(height: 20),
              //
              // SizedBox(
              //   width: double.infinity,
              //   child: Wrap(
              //     spacing: 17,
              //     runSpacing: 12,
              //     children: [
              //       SizedBox(
              //         width: (MediaQuery
              //             .of(context)
              //             .size
              //             .width - 40 - 17) / 2,
              //         child: myItemWidget(
              //           context: context,
              //           title: 'History',
              //           icon: Icons.history,
              //           onTap: () {
              //             Get.toNamed(Routes.HISTORY, arguments: null);
              //           },
              //         ),
              //       ),
              //       SizedBox(
              //         width: (MediaQuery
              //             .of(context)
              //             .size
              //             .width - 40 - 5) / 2,
              //         child: myItemWidget(
              //           context: context,
              //           title: 'Achievement',
              //           icon: Icons.workspace_premium,
              //           onTap: () {
              //             Get.toNamed(Routes.ACHIEVEMENT);
              //           },
              //         ),
              //       ),
              //       SizedBox(
              //         width: (MediaQuery
              //             .of(context)
              //             .size
              //             .width - 40 - 17) / 2,
              //         child: myItemWidget(
              //           context: context,
              //           title: 'Notification',
              //           icon: Icons.notifications_outlined,
              //           onTap: () {
              //             Get.toNamed(Routes.NOTIFICATION);
              //           },
              //         ),
              //       ),
              //       SizedBox(
              //         width: (MediaQuery
              //             .of(context)
              //             .size
              //             .width - 40 - 5) / 2,
              //         child: myItemWidget(
              //           context: context,
              //           title: 'Language',
              //           icon: Icons.language_outlined,
              //           onTap: () {
              //             Get.toNamed(Routes.LANGUAGE);
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              InkWell(
                // borderRadius: BorderRadius.circular(12), // để splash bo góc
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {},
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
                          themeController.themeMode.value == ThemeMode.dark
                              ? 'dark_mode'.tr
                              : 'light_mode'.tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            bool isDark =
                                themeController.themeMode.value ==
                                ThemeMode.dark;
                            themeController.toggleTheme(!isDark);
                          },
                          child: Container(
                            width: 60,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color:
                                  themeController.themeMode.value ==
                                          ThemeMode.dark
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[400],
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  alignment:
                                      themeController.themeMode.value ==
                                              ThemeMode.dark
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 3,
                                      bottom: 3,
                                      left: 5,
                                      right: 5,
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

              const SizedBox(height: 20),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {},
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
                          'language'.tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          final isVietnamese = Get.locale?.languageCode == 'vi';
                          final newLocale =
                              isVietnamese
                                  ? const Locale('en', 'US')
                                  : const Locale('vi', 'VN');
                          Get.updateLocale(newLocale);
                        },
                        child: Container(
                          width: 60,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                Get.locale?.languageCode == 'en'
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey[400],
                          ),
                          child: Stack(
                            children: [
                              AnimatedAlign(
                                alignment:
                                    Get.locale?.languageCode == 'vi'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 3,
                                    bottom: 3,
                                    left: 5,
                                    right: 5,
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  ProfileController.logout();
                  print('Tapped logout');
                },
                child: Ink(
                  height: 45,
                  width: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'logout'.tr,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
