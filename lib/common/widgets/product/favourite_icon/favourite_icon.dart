import 'package:ecommerce_app/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(() => TCircularIcon(
          icon: controller.isFavourite(productId)
              ? Iconsax.heart5
              : Iconsax.heart,
          color: controller.isFavourite(productId) ? Colors.red : null,
          onPressed: () => controller.toogleFavouriteProduct(productId),
        ));
  }
}
