import 'package:ecommerce_app/features/authantication/controllers/onboarding_controller.dart';
import 'package:ecommerce_app/features/authantication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:ecommerce_app/features/authantication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:ecommerce_app/features/authantication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecommerce_app/features/authantication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(OnBoardingCOntroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingScreenImage1,
                title: TText.onBoardingTitle1,
                subtitle: TText.onBoardingSUbTitle1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingScreenImage2,
                title: TText.onBoardingTitle2,
                subtitle: TText.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingScreenImage3,
                title: TText.onBoardingTitle3,
                subtitle: TText.onBoardingSubTitle3,
              )
            ],
          ),
          const OnBoardingSkip(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
