import 'package:ecommerce_app/common/widgets/login_divider.dart';
import 'package:ecommerce_app/common/widgets/social_button.dart';
import 'package:ecommerce_app/features/authantication/screens/signup/widgets/sign_up_form.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class SighnUpScreen extends StatelessWidget {
  const SighnUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title

              Text(
                "Let's create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              SignUpFormScreen(dark: dark),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              TFormDivider(
                dark: dark,
                dividerText: 'or Sign up with',
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
