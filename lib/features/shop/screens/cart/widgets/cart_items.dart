import 'package:ecommerce_app/common/widgets/product/cart/t_cart_item.dart';
import 'package:ecommerce_app/common/widgets/product/cart/tproduct_quantity_add_removes.dart';
import 'package:ecommerce_app/common/widgets/texts/product_price_text.dart';
import 'package:ecommerce_app/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,
  });
  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    return Obx(() {
      return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: cartController.cartItems.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => Obx(() {
          final item = cartController.cartItems[index];
          return Column(
            children: [
              TCartItem(
                cartitem: item,
              ),
              if (showAddRemoveButton)
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityWithAddAndRemovedButton(
                          quantity: item.quantity,
                          add: () => cartController.addonetoCart(item),
                          remove: () => cartController.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    TProductPriceText(
                        price: (item.price * item.quantity).toStringAsFixed(1))
                  ],
                )
            ],
          );
        }),
      );
    });
  }
}
