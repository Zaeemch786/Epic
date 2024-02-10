import 'package:ecommerce_app/Navigation_menu.dart';
import 'package:ecommerce_app/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce_app/data/respositories/order/order_repository.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/adress_controller.dart';
import 'package:ecommerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_app/features/shop/controllers/product/check_out_controller.dart';
import 'package:ecommerce_app/features/shop/models/order_model.dart';
import 'package:ecommerce_app/utills/constants/enum.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  final cartController = Get.put(CartController());
  final adressController = Get.put(AdressController());
  final checkOutController = Get.put(CheckOutController());
  final orderRepository = Get.put(OrderRepository());

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();
      return userOrders;
    } catch (e) {
      TFullScreenLoader.warningSnakBar(
          title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void processOrder(double totalAmount) async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'Processing your order', TImages.diliveredEmailIllustration);
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      if (adressController.selectedAdress.value.id.isEmpty) {
        TFullScreenLoader.warningSnakBar(
          title: 'Please add an address before placing an order',
        );
        // message: 'Add items in the cart in order to proceed');
        TFullScreenLoader.stopLoading();
      } else {
        final order = OrderModel(
            id: UniqueKey().toString(),
            userId: userId,
            status: OrderStatus.pending,
            paymentMethod: checkOutController.selectedPaymentMethod.value.name,
            adress: adressController.selectedAdress.value,
            deliveryDate: DateTime.now(),
            items: cartController.cartItems.toList(),
            totalAmount: totalAmount,
            orderDate: DateTime.now());
        await orderRepository.saveOrder(order, userId);
        cartController.clearCart();
        Get.off(
          () => SucessScreen(
              image:
                  'https://lottie.host/44b3d113-55e1-4bb7-9412-60f74b5331ef/CDlMVEzeua.json',
              subtitle: 'Your item will be shipped soon!',
              title: 'Payment Success!',
              onPressed: () => Get.offAll(() => NavigationMenuBar())),
        );
      }
    } catch (e) {
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
