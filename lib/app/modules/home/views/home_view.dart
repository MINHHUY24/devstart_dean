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
              'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images/Group%2023.svg',
              width: 55,
              height: 55,
            ),

            const SizedBox(width: 40),

            Flexible(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    print('Favorite pressed');
                  },
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
                          Icon(
                            Icons.favorite,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '10',
                            style: TextStyle(
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
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    print('Fire pressed');
                  },
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
                          const Icon(
                            Icons.local_fire_department,
                            color: Color(0xFFFF6B00),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '10',
                            style: TextStyle(
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
            ),
            const SizedBox(width: 12),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  print('Notification pressed');
                },
                child: Ink(
                  height: 40,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF374156),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
