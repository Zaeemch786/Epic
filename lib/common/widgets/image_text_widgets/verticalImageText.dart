import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TVerticalImageText extends StatelessWidget {
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final String title, image;
  final void Function()? onTap;
  const TVerticalImageText(
      {super.key,
      this.textColor = TColors.white,
      this.backgroundColor,
      required this.title,
      this.onTap,
      required this.image,
      this.isNetworkImage = true});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
          child: Column(
            children: [
              Container(
                  width: 56,
                  height: 56,
                  padding: const EdgeInsets.all(TSizes.sm),
                  decoration: BoxDecoration(
                      color: backgroundColor ??
                          (dark ? TColors.black : TColors.white),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: isNetworkImage
                          ? Image.network(
                              image,
                              fit: BoxFit.contain,
                              // color: dark ? TColors.light : TColors.dark,
                            )
                          : Image.asset(
                              'assets/images/nike.png',
                              color: dark ? TColors.light : TColors.dark,
                            ))),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ));
  }
}
