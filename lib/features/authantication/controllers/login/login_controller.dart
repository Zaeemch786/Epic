import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/authantication/controllers/usercontroller/user_controller.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final rememberme = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final userController = Get.put(UserController());
  // @override
  // void onInit() {
  //   emailCtrl.text = localStorage.read('REMEMBER-ME-EMAILL');
  //   passwordCtrl.text = localStorage.read('REMEMBER-ME-PASSWORD');
  //   super.onInit();
  // }

  Future<void> emailandPasswordSignIn() async {
    try {
      TFullScreenLoader.oprnLoadingDialog('Logging you in...',
          "https://lottie.host/7d7bda26-5bed-43ee-99b3-5c88aecc2e6f/rvt9qSzMsE.json");
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (rememberme.value) {
        localStorage.write('REMEMBER-ME-EMAIL', emailCtrl.text.trim());
        localStorage.write('REMEMBER-ME-PASSWORD', passwordCtrl.text.trim());
      }
      // ignore: unused_local_variable
      final userCredendtial = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
              emailCtrl.text.trim(), passwordCtrl.text.trim());
      TFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<void> googleSignIn() async {
    try {
      // Start Loading
      TFullScreenLoader.oprnLoadingDialog(
          'Logging you in...', TImages.diliveredEmailIllustration);

      // Check Internet Connectivity
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.sighnInWithGoogle();

      // Save User Record
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
