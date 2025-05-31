import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  var isLoading = false.obs;

  final count = 0.obs;
  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: "6105728895-uej6fgr9bv97ogpb96qmn00c31n8r3c6.apps.googleusercontent.com",
        serverClientId: "6105728895-nsl6c08uunqch1v9nqt21r68oj4ghj8g.apps.googleusercontent.com",
      );
      final googleSignInAcount = await googleSignIn.signIn();
      final googleAuth = await googleSignInAcount!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception("Access token is null");
      }
      if (idToken == null) {
        throw Exception("Id token is null");
      }
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      Get.offAllNamed(Routes.MOBILE_LAYOUT);
    }
    catch (e) {
      if(kDebugMode){
        print("========================");
        print('Error login with google: $e');
      }
    }
  }

  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
