import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewiewController extends GetxController {
  static RewiewController get instance => Get.find();

  final msgController = TextEditingController();

  void postMessage() {
    final userId = AuthenticationRepository.instance.authUser;
    if (msgController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('user post').add({
        'UserEmail': userId,
        'Message': msgController.text,
        'Timestamp': Timestamp.now(),
        'Likes': []
      });
    }

    msgController.clear();
  }
}
