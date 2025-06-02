import 'package:devstart/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryView', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2, top: 25),
        child: Column(
          children: [
            Center(
              child: CustomSearchBar(
                controller: searchController,
                onSearch: () {
                  final query = searchController.text.trim();
                  print('Searching for: $query');
                  // controller.search(query); // nếu bạn có hàm search
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
