import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TShimmerEffect extends StatelessWidget {
  const TShimmerEffect(
      {super.key,
      required this.width,
      required this.height,
      this.radius = 15,
      this.color});
  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
        baseColor: darkMode ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: darkMode ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color ?? (darkMode ? TColors.darkGrey : TColors.white),
              borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
