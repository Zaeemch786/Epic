import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:flutter/material.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo, Title and Subtitle
        Image(
            height: 100,
            width: 100,
            image:
                AssetImage(dark ? TImages.darkAppLogo : TImages.lightAppLogo)),
        Text(
          "Welcome back",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Discover Limitless Choices and Unmatched Convenience",
          style: Theme.of(context).textTheme.bodyMedium,
        )
      ],
    );
  }
}
