import 'package:ecommerce_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/container/search_containers.dart';
import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/product/product_card_vertical.dart';
import 'package:ecommerce_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_app/features/shop/screens/all_products/all_product.dart';
import 'package:ecommerce_app/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:ecommerce_app/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce_app/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
        body: LiquidPullToRefresh(
      onRefresh: controller.fetchCategories,
      animSpeedFactor: 2,
      height: MediaQuery.of(context).size.height * 1 * 0.2,
      color: TColors.primary,
      showChildOpacityTransition: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const THomeAppBar(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSearchContainer(
                    text: 'Search in Store',
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        TSectionHadding(
                          title: 'Popular Categories',
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const THomeCategories()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    TPromoSlider(
                      banners: const [
                        "assets/images/nike1.png",
                        "assets/images/nike2.png",
                        "assets/logos/snow.jpg",
                        "assets/logos/tagged.png",
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TSectionHadding(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => const AllPrdocut(
                            title: 'Popular Products',
                          )),
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TVerticalProductShimmer();
                      }
                      if (controller.featuredCategories.isEmpty) {
                        return Center(
                          child: Text(
                            'NO Data Found!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      return TGridLayout(
                        itemCount: controller.featuredCategories.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                          categoryModel: controller.featuredCategories[index],
                        ),
                      );
                    })
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

String green =
    'https://c0.klipartz.com/pngpicture/323/773/sticker-png-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-sneakers-shoe-electric-blue-thumbnail.png';
String red =
    'https://e7.pngegg.com/pngimages/723/143/png-clipart-shoe-nike-free-air-force-nike-shoes-image-file-formats-fashion-thumbnail.png';
String pink =
    'https://c0.klipartz.com/pngpicture/57/434/gratis-png-zapatillas-nike-air-max-shoe-air-jordan-zapatos-de-hombre-thumbnail.png';
String black =
    'https://p7.hiclipart.com/preview/967/334/474/nike-free-shoe-nike-air-max-running-jogging-shoes.jpg';
