import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/authantication/models/usermodel.dart';
import 'package:ecommerce_app/utills/exceptions/firbase_exception.dart';
import 'package:ecommerce_app/utills/exceptions/formate_exception.dart';
import 'package:ecommerce_app/utills/exceptions/platform_exception.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      TFullScreenLoader.errorSnakBar(title: 'title', message: e.toString());
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<UserModel?> fetchUserDetails() async {
    try {
      final docummentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (docummentSnapshot.exists) {
        return UserModel.fromsnapshot(docummentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
    return null;
  }

  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
  }

  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TformateException();
    } on PlatformException catch (e) {
      TPlatFormException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, please try again';
    }
    return '';
  }
}
