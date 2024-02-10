import 'package:ecommerce_app/common/widgets/custom_shapes/container/t_rounded_container.dart';
import 'package:ecommerce_app/features/shop/controllers/product/check_out_controller.dart';
import 'package:ecommerce_app/features/shop/models/payment_method_model.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TPaymentTile extends StatelessWidget {
  const TPaymentTile({super.key, required this.payMentMethod});
  final PayMentMethodModel payMentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckOutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = payMentMethod;
        Get.back();
      },
      leading: TRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.light
            : TColors.white,
        padding: const EdgeInsets.all(TSizes.sm),
        child: Center(
          child: Image(
            image: AssetImage(payMentMethod.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(payMentMethod.name),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
