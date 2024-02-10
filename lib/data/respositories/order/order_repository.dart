import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/shop/models/order_model.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty)
        throw 'Unable to find user information. Try again in few minutes.';
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs
          .map(
              (doccumentSnapshot) => OrderModel.fromSnapShot(doccumentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong while fetch Order information. Try again later.';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .add(order.toJson());
    } catch (e) {
      throw 'Something went wrong while fetch Order information. Try again later.';
    }
  }
}
