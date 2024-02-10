import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/device/device_utillity.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSearchContainer extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool showBackground, showborder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const TSearchContainer(
      {super.key,
      this.icon = Iconsax.search_normal,
      this.showBackground = true,
      this.showborder = true,
      this.onTap,
      required this.text,
      this.padding =
          const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace)});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(TSizes.md),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                TSizes.cardRadiusLg,
              ),
              color: showBackground
                  ? dark
                      ? TColors.dark
                      : TColors.light
                  : Colors.transparent,
              border: showborder ? Border.all(color: TColors.darkGrey) : null),
          child: Row(
            children: [
              Icon(
                icon,
                color: dark ? TColors.darkGrey : TColors.grey,
              ),
              const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
