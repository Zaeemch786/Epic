import 'package:ecommerce_app/common/widgets/texts/t_brand_text_sizes.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/enum.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconCOlor = TColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSizes = TextSIzes.small,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconCOlor;
  final TextAlign? textAlign;
  final TextSIzes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: (TBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSizes: brandTextSizes,
        ))),
        const SizedBox(
          width: TSizes.xs,
        ),
        Icon(
          Iconsax.verify5,
          color: iconCOlor,
          size: TSizes.iconXS,
        )
      ],
    );
  }
}
