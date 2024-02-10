import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/shimmers/t_shimmer_effect.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';

class TVerticalProductShimmer extends StatelessWidget {
  final int itemcount;
  const TVerticalProductShimmer({super.key, this.itemcount = 4});

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemcount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TShimmerEffect(width: 180, height: 150),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TShimmerEffect(width: 160, height: 15),
                  SizedBox(height: TSizes.spaceBtwItems / 2),
                  TShimmerEffect(width: 110, height: 15),
                ],
              ),
            ));
  }
}
