import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/utills/exceptions/firbase_exception.dart';
import 'package:ecommerce_app/utills/exceptions/platform_exception.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CategoryPepository extends GetxController {
  static CategoryPepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  ///Get all catgeories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      // ignore: non_constant_identifier_names
      final List = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return List;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatFormException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<CategoryModel>> getFauoriteProducts(
      List<String> productIds) async {
    try {
    if (productIds.isEmpty) {
      return [];
    }
    final snapshot = await _db
        .collection('Categories')
        .where(FieldPath.documentId, whereIn: productIds)
        .get();
    return snapshot.docs
        .map((querySnapshot) => CategoryModel.fromSnapshot(querySnapshot))
        .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatFormException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categorieId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParrentId', isEqualTo: categorieId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatFormException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // Future<List<CategoryModel>> getProductsForCategory(
  //     {required String categoryId, int limit = 4}) async {
  //   try {
  //     QuerySnapshot productCategoryQuerry = limit == -1
  //         ? await _db
  //             .collection('ProductCategory')
  //             .where('CategoryId', isEqualTo: categoryId)
  //             .get()
  //         : await _db
  //             .collection('ProductCategory')
  //             .where('CategoryId', isEqualTo: categoryId)
  //             .limit(limit)
  //             .get();
  //     List<String> productsIds = productCategoryQuerry.docs
  //         .map((doc) => doc['productId'] as String)
  //         .toList();
  //     final productsQuerry = await _db
  //         .collection('CategoryId')
  //         .where(FieldPath.documentId, whereIn: productsIds)
  //         .get();
  //     List<CategoryModel> products = productsQuerry.docs
  //         .map((doc) => CategoryModel.fromSnapshot(doc))
  //         .toList();
  //     return products;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatFormException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong. Please try again";
  //   }
  // }

  ///Get Sub catgeories

  /// Upload catgeories to the CLoud Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(TFirebaseStorageService());
      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);
        final url =
            await storage.uploadImageData('Categories', file, category.name);
        category.image = url;
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatFormException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();
  final _firebaseStorage = FirebaseStorage.instance;
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw 'Error loading image data: $e';
    }
  }

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'FirebaseEception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error:${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }

  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (e is FirebaseException) {
        throw 'FirebaseEception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error:${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }
}
