import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor, // Dark background
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : SvgPicture.network(
                        Theme.of(context).brightness == Brightness.dark
                            ? 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//Group%2023.svg'
                            : 'https://kmwzwjwbkjvaghlkzpck.supabase.co/storage/v1/object/public/images//logo_light.svg',
                        width: 150,
                        height: 150,
                        placeholderBuilder:
                            (context) => const CircularProgressIndicator(),
                        semanticsLabel: 'DevStart Logo',
                      ),
                  const SizedBox(height: 150),

                  Text(
                    "Welcome to DevStart!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).appBarTheme.titleTextStyle?.color,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "From ideas to action. From challenges to skills.",
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: () async {
                      await controller.loginWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).primaryColor, // Mint green
                      padding: const EdgeInsets.symmetric(
                        horizontal: 70,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/640px-Google_%22G%22_logo.svg.png',
                      height: 24,
                    ),
                    label: const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
