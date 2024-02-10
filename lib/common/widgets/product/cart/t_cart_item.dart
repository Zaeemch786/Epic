import 'package:ecommerce_app/common/widgets/images/round_images.dart';
import 'package:ecommerce_app/common/widgets/texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce_app/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce_app/features/shop/models/cart_item_model.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.cartitem,
  });
  final CartItemModel cartitem;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      TRoundedImage(
        isNetworkImage: true,
        imageUrl: cartitem.image ?? '',
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(TSizes.sm),
        backgroundColor: THelperFunctions.isDarkMode(context)
            ? TColors.darkGrey
            : TColors.light,
      ),
      const SizedBox(
        width: TSizes.spaceBtwItems,
      ),
      Expanded(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TBrandTitleWithVerifiedIcon(title: cartitem.brandName ?? ''),
          const Flexible(
            child: TProductTitileyText(
              title: 'Black Sports Shoes',
              maxLines: 1,
            ),
          ),
          Text.rich(TextSpan(
              children: (cartitem.selectedVariation ?? {})
                  .entries
                  .map((e) => TextSpan(children: [
                        TextSpan(
                            text: e.key,
                            style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(
                            text: e.value,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ]))
                  .toList())),
        ],
      ))
    ]);
  }
}
// Text.rich(TextSpan(children: [
//                 TextSpan(
//                     text: 'Color',
//                     style: Theme.of(context).textTheme.bodySmall),
//                 TextSpan(
//                     text: 'Green',
//                     style: Theme.of(context).textTheme.bodyLarge),
//                 TextSpan(
//                     text: 'Size ',
//                     style: Theme.of(context).textTheme.bodySmall),
//                 TextSpan(
//                     text: 'UK 08', style: Theme.of(context).textTheme.bodyLarge)
//               ]))