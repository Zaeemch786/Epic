import 'dart:async';

import 'package:ecommerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  @override
  void onInit() {
    sendEmailVerification();
    sendTimerForAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TFullScreenLoader.sucessSnakBar(
          title: 'Email Sent',
          message: 'Please Check your inbox and verify your email');
    } catch (e) {
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  sendTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SucessScreen(
            image:
                "https://lottie.host/7d7bda26-5bed-43ee-99b3-5c88aecc2e6f/rvt9qSzMsE.json",
            subtitle:
                'Welcome to Your Ultimate Shopping Destination; Your Account is Created, Unleash the Joy of Seamless Online Shopping',
            title: 'Your account successfully created!',
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SucessScreen(
          image:
              "https://lottie.host/7d7bda26-5bed-43ee-99b3-5c88aecc2e6f/rvt9qSzMsE.json",
          subtitle:
              'Welcome to Your Ultimate Shopping Destination; Your Account is Created, Unleash the Joy of Seamless Online Shopping',
          title: 'Your account successfully cread!',
          onPressed: () => AuthenticationRepository.instance.screenRedirect()));
    }
  }
}
