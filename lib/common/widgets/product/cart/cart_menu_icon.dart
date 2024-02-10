import 'package:ecommerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_app/features/shop/screens/cart/cart.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TCartCounterIcon extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final Color? iconColor, counterBgColor, CounterTextColor;
  const TCartCounterIcon(
      {super.key,
      required this.iconColor,
      this.counterBgColor,
      // ignore: non_constant_identifier_names
      this.CounterTextColor});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Stack(children: [
      IconButton(
        onPressed: () => Get.to(() => const CartScreen()),
        icon: Icon(
          Iconsax.shopping_bag,
          color: iconColor,
        ),
      ),
      Positioned(
        right: 0,
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
              color: TColors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100)),
          child: Center(
            child: Obx(
              () => Text(
                controller.noOfCartItems.value.toString(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.white),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
