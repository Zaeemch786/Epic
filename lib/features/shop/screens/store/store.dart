import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/appbar/tapbar.dart';
import 'package:ecommerce_app/common/widgets/brands/brand_cart.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/container/search_containers.dart';
import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/product/cart/cart_menu_icon.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce_app/features/shop/screens/brand/all_brand.dart';
import 'package:ecommerce_app/features/shop/screens/store/widgets/categorie_tabs.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryController.instance.featuredCategories;
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            'Store',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
              iconColor: dark ? TColors.white : TColors.black,
            )
          ],
        ),
        body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: dark ? TColors.black : TColors.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          const TSearchContainer(
                            text: 'Search in Store',
                            showborder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          TSectionHadding(
                            title: 'Featured Brands',
                            onPressed: () =>
                                Get.to(() => const AllBrandScreen()),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),
                          TGridLayout(
                              mainAxisextent: 80,
                              itemCount: 4,
                              itemBuilder: (_, index) {
                                return const TBrandCard(
                                  showBorder: true,
                                );
                              })
                        ],
                      ),
                    ),
                    bottom: TTapbBar(
                        tabs: categories
                            .map((categories) =>
                                Tab(child: Text(categories.name)))
                            .toList()))
              ];
            },
            body: TabBarView(
                children: categories
                    .map((categories) => TCategorieTab(
                          categoryModel: categories,
                        ))
                    .toList())),
      ),
    );
  }
}
