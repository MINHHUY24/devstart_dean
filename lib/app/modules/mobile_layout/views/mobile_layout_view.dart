import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mobile_layout_controller.dart';

class MobileLayoutView extends GetView<MobileLayoutController> {
  const MobileLayoutView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
          () => Scaffold(
        body: Container(
          color: Colors.white,
          child: controller.pages[controller.selectedIndex.value],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeTab,
          backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
          selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
          theme.bottomNavigationBarTheme.unselectedItemColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon:
              controller.selectedIndex.value == 0
                  ? Container(
                width: 60,
                height: 34,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                  theme.bottomNavigationBarTheme.selectedItemColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:
              controller.selectedIndex.value == 1
                  ? Container(
                width: 60,
                height: 34,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                  theme.bottomNavigationBarTheme.selectedItemColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.menu_book_outlined),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon:
              controller.selectedIndex.value == 2
                  ? Container(
                width: 60,
                height: 34,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color:
                  theme.bottomNavigationBarTheme.selectedItemColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
              )
                  : const Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
