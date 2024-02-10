import 'package:ecommerce_app/common/widgets/brands/brand_shoe_case.dart';
import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/product/product_card_vertical.dart';
import 'package:ecommerce_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategorieTab extends StatelessWidget {
  const TCategorieTab({
    super.key,
    required this.categoryModel,
  });
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const TBrandShowCase(
                  images: [
                    "assets/images/nike1.png",
                    "assets/images/nike.png",
                    "assets/images/nike2.png",
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TSectionHadding(
                  title: 'You might Like',
                  onPressed: () {},
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
                        'No Data Found!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return TGridLayout(
                      itemCount: controller.featuredCategories.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                            categoryModel: controller.featuredCategories[index],
                          ));
                }),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                )
              ],
            ),
          ),
        ]);
  }
}
