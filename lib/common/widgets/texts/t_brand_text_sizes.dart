import 'package:ecommerce_app/utills/constants/enum.dart';
import 'package:flutter/material.dart';

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText(
      {super.key,
      this.color,
      required this.title,
      this.maxLines = 1,
      this.textAlign = TextAlign.center,
      this.brandTextSizes = TextSIzes.small});
  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSIzes brandTextSizes;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: brandTextSizes == TextSIzes.small
          ? textTheme.labelLarge!.apply(color: color)
          : brandTextSizes == TextSIzes.medium
              ? textTheme.titleLarge!.apply(color: color)
              : textTheme.bodyMedium!.apply(color: color),
    );
  }
}
