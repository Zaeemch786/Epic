import 'package:ecommerce_app/common/styles/spacing_styles.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SucessScreen extends StatelessWidget {
  final String image, title, subtitle;
  final VoidCallback onPressed;
  const SucessScreen(
      {super.key,
      required this.image,
      required this.subtitle,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TspacingStyle.padiingWithAppBarHeight * 2,
          child: Column(
            children: [
              Lottie.network(image,
                  width: THelperFunctions.screenWidth() * 0.6),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Title & subTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed, child: const Text("Continue")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
