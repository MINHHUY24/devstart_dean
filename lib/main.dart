import 'package:devstart/theme/theme.dart';
import 'package:devstart/widgets/playTurnController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';
import 'app/services/notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: 'https://kmwzwjwbkjvaghlkzpck.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imttd3p3andia2p2YWdobGt6cGNrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg0MDE0NjcsImV4cCI6MjA2Mzk3NzQ2N30.Z_F9_TqnKMIL-xyiqFT4QV25GVZqvujsRnKhPua_LVs',
  );

  await NotificationService.init();

  final themeController = Get.put(ThemeController());
  await themeController.loadTheme();

  Get.put(PlayTurnController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: myLightTheme,
        darkTheme: myDarkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    );
  }
}
