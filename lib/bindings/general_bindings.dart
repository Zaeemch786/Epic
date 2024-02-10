import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetWorkManager());
    Get.put(VariationController());
  }
}
