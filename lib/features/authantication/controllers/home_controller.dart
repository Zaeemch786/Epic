import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final carsualCurrentIndex = 0.obs;
  void updatePageIndicator(index) {
    carsualCurrentIndex.value = index;
  }
}
