import 'package:ecommerce_app/data/respositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/authantication/models/usermodel.dart';
import 'package:ecommerce_app/features/authantication/screens/signup/widgets/verify_email_screen.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signUp() async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'We are processing your information..',
          "https://lottie.host/44b3d113-55e1-4bb7-9412-60f74b5331ef/CDlMVEzeua.json");
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!privacyPolicy.value) {
        TFullScreenLoader.warningSnakBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        Get.back();
        return;
      }
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');
      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.sucessSnakBar(
          title: 'Congratulations',
          message: 'Your account has been created! Verify email to continue');
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
