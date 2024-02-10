import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/authantication/screens/password_configuration/reset_password_screen.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoegetPasswordController extends GetxController {
  static FoegetPasswordController get instance => Get.find();
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  sendPasswordResetEmail() async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'Processing your request...', TImages.diliveredEmailIllustration);
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .sendPasswordResestEmail(email.text.trim());
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.sucessSnakBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resetPasswordEmail(String email) async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'Processing your request...', TImages.diliveredEmailIllustration);
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.sendPasswordResestEmail(email);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.sucessSnakBar(
          title: 'Email Sent',
          message: 'Email Link Sent to Reset your Password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
