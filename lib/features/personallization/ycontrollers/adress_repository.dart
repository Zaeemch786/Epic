import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/personallization/models/adress_model.dart';
import 'package:get/get.dart';

class AdressRepository extends GetxController {
  static AdressRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  Future<List<AdressModel>> fetchUserAdress() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((doccumentSnapshot) =>
              AdressModel.fromDoccoumentSnapshpt(doccumentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetching Adress information, Tryagain later';
    }
  }

  Future<void> updateSelectedField(String adressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(adressId)
          .update({'SelectedAdress': selected});
    } catch (e) {
      throw 'Unable to update your adress selection. Try again later';
    }
  }

  Future<String> addAdress(AdressModel adress) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAdress = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(adress.toJson());
      return currentAdress.id;
    } catch (e) {
      throw 'Something went wrong while saving Address Information. Try agin later';
    }
  }
}
