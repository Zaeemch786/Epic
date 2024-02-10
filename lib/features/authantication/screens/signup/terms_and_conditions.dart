import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'i agree to ',
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: 'Privacy Policy',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary)),
          TextSpan(text: ' and ', style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: 'terms of use',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary)),
        ]))
      ],
    );
  }
}
