import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            animation,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: dark ? TColors.light : TColors.dark),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
