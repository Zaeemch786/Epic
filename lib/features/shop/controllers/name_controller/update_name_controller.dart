import 'package:ecommerce_app/data/respositories/user/user_repository.dart';
import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/authantication/controllers/usercontroller/user_controller.dart';
import 'package:ecommerce_app/features/personallization/screens/profile/profile.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameKey = GlobalKey<FormState>();
  @override
  void onInit() {
    inixtializeName();
    super.onInit();
  }

  Future<void> inixtializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'We are updating your informatiom', TImages.onBoardingScreenImage2);
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!updateUserNameKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        "LastName": lastName.text.trim()
      };
      await userRepository.updateSingleField(name);
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.sucessSnakBar(
          title: 'Congratulations', message: 'Your Name ha been updated');
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
