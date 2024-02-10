import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:ecommerce_app/common/widgets/images/round_images.dart';
import 'package:ecommerce_app/features/authantication/controllers/home_controller.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  TPromoSlider({super.key, required this.banners});

  final controllers = Get.put(HomeController());
  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
            options: CarouselOptions(
              onPageChanged: (index, _) =>
                  controllers.updatePageIndicator(index),
              viewportFraction: 1,
              autoPlay: true,
              // autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            )),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Center(
          child: Obx(() {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backGroundColor: controllers.carsualCurrentIndex.value == i
                        ? TColors.primary
                        : TColors.dark,
                  ),
              ],
            );
          }),
        )
      ],
    );
  }
}

List banner = [
  "assets/images/joyland.jpg",
  "assets/images/snow.jpg",
  "assets/images/tagged.png",
  "assets/images/tagged2.png",
];
