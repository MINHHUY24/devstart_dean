import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fill_in_the_blanks_controller.dart';

class FillInTheBlanksView extends GetView<FillInTheBlanksController> {
  const FillInTheBlanksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FillInTheBlanksView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FillInTheBlanksView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
