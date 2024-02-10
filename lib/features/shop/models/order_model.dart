import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/personallization/models/adress_model.dart';
import 'package:ecommerce_app/features/shop/models/cart_item_model.dart';
import 'package:ecommerce_app/utills/constants/enum.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AdressModel? adress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  OrderModel(
      {required this.id,
      this.userId = '',
      required this.status,
      required this.items,
      required this.totalAmount,
      required this.orderDate,
      this.paymentMethod = 'Paypal',
      this.adress,
      this.deliveryDate});
  String get formattedOrderDate => THelperFunctions.getFormateDate(orderDate);
  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormateDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.deliverd
      ? 'Delivered'
      : status == OrderStatus.shipped
          ? 'shipment on the way'
          : 'Processing';
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'adress': adress?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory OrderModel.fromSnapShot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
        id: data['id'] as String,
        userId: data['userId'] as String,
        status: OrderStatus.values
            .firstWhere((e) => e.toString() == data['status']),
        items: (data['items'] as List<dynamic>)
            .map((itemData) =>
                CartItemModel.fromJson(itemData as Map<String, dynamic>))
            .toList(),
        totalAmount: data['totalAmount'] as double,
        orderDate: (data['orderDate'] as Timestamp).toDate(),
        paymentMethod: data['paymentMethod'] as String,
        adress: AdressModel.fromMap(data['adress'] as Map<String, dynamic>),
        deliveryDate: data['deliveryDate'] == null
            ? null
            : (data['deliveryDate'] as Timestamp).toDate());
  }

  static fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> doccumentSnapshot) {}
}
