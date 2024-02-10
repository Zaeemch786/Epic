import 'package:ecommerce_app/common/widgets/custom_shapes/container/t_rounded_container.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/controllers/product/check_out_controller.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingPaymentSection extends StatelessWidget {
  const TBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutController = Get.put(CheckOutController());
    final darkmode = THelperFunctions.isDarkMode(context);

    return Column(
      children: [
        TSectionHadding(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => checkOutController.selectPaymentMethod(context),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems / 2,
        ),
        Obx(
          () => Row(
            children: [
              TRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: darkmode ? TColors.light : TColors.white,
                padding: const EdgeInsets.all(TSizes.sm),
                child: Image(
                    image: AssetImage(
                        checkOutController.selectedPaymentMethod.value.image)),
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems / 2,
              ),
              Text(
                checkOutController.selectedPaymentMethod.value.name,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        )
      ],
    );
  }
}
