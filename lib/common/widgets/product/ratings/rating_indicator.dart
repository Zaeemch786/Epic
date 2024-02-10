import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class TRatingBarIndicator extends StatelessWidget {
  const TRatingBarIndicator({
    super.key,
    required this.ratings,
  });
  final double ratings;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        rating: ratings,
        itemSize: 17,
        unratedColor: TColors.grey,
        itemBuilder: (_, __) => const Icon(
              Iconsax.star,
              color: TColors.primary,
            ));
  }
}
