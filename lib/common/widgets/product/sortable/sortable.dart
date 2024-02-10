import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/product/product_card_vertical.dart';
import 'package:ecommerce_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSortableProduct extends StatelessWidget {
  const TSortableProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Column(
      children: [
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: [
              'Name',
              'Higher Price',
              'Lowest Price',
              'Sale',
              'Newest',
              'Popularity'
            ]
                .map((option) =>
                    DropdownMenuItem(value: option, child: Text(option)))
                .toList(),
            onChanged: (value) {}),
        const SizedBox(
          height: TSizes.spaceBtwSections,
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
                  ));
        })
      ],
    );
  }
}
