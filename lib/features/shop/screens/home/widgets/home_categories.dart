import 'package:ecommerce_app/common/widgets/image_text_widgets/verticalImageText.dart';
import 'package:ecommerce_app/common/widgets/shimmers/t_shimmer_effect.dart';
import 'package:ecommerce_app/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_app/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    // // ignore: unused_local_variable
    // List<String> image = [
    //   'assets/images/nike2.png',
    //   'assets/images/nike1.png',
    //   'assets/images/nike.png',
    //   'assets/images/nike2.png',
    //   'assets/images/nike.png',
    //   'assets/images/nike2.png',
    // ];
    return Obx(() {
      if (categoryController.isLoading.value) return const TCategoriesShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: categoryController.featuredCategories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final category = categoryController.featuredCategories[index];
              return TVerticalImageText(
                  title: category.name,
                  image: category.image,
                  isNetworkImage: true,
                  onTap: () => Get.to(() => SubCategoriesScreen(
                        category: category,
                      )));
            }),
      );
    });
  }
}

class TCategoriesShimmer extends StatelessWidget {
  const TCategoriesShimmer({super.key, this.itemCount = 6});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return const Column(
            children: [
              TShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),
              SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              TShimmerEffect(width: 55, height: 8)
            ],
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
      ),
    );
  }
}
