import 'package:ecommerce_app/common/widgets/custom_shapes/container/t_rounded_container.dart';
import 'package:ecommerce_app/features/personallization/models/adress_model.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/adress_controller.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAdress extends StatelessWidget {
  const TSingleAdress({
    super.key,
    required this.adress,
    required this.onTap,
  });
  final AdressModel adress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AdressController.instance;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Obx(() {
      final selectedAdressId = controller.selectedAdress.value.id;
      final selectedAdress = selectedAdressId == adress.id;
      return InkWell(
        onTap: onTap,
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          backgroundColor: selectedAdress
              ? TColors.primary.withOpacity(0.5)
              : Colors.transparent,
          borderColor: selectedAdress
              ? Colors.transparent
              : darkMode
                  ? TColors.darkGrey
                  : TColors.grey,
          margin: const EdgeInsets.only(
            bottom: TSizes.spaceBtwItems,
          ),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedAdress ? Iconsax.tick_circle5 : null,
                  color: selectedAdress
                      ? darkMode
                          ? TColors.light
                          : TColors.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adress.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    adress.formattedPhoneNo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: TSizes.sm / 2,
                  ),
                  Text(
                    adress.toString(),
                    softWrap: true,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
