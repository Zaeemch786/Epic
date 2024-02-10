import 'package:ecommerce_app/Navigation_menu.dart';
import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce_app/common/widgets/product/product_card_vertical.dart';
import 'package:ecommerce_app/common/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:ecommerce_app/features/shop/screens/home/home.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/cloud_helper_funstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class WhishListScreen extends StatelessWidget {
  const WhishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoruite = Get.put(FavouriteController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          'Whishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          TCircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: favoruite.favoriteProducts(),
                    builder: (context, snapshot) {
                      final emptyWidget = TAnimationLoaderWidget(
                        text: 'Whoops! Wishlist is Empty...',
                        animation: TImages.diliveredEmailIllustration,
                        onActionPressed: () =>
                            Get.off(() => NavigationMenuBar()),
                      );
                      const loader = TVerticalProductShimmer(
                        itemcount: 6,
                      );
                      final widget = TcloudHelperFunction.checkMultiRecordstate(
                          snapshot: snapshot,
                          loader: loader,
                          nothingFound: emptyWidget);
                      if (widget != null) return widget;
                      final products = snapshot.data!;

                      return TGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                                categoryModel: products[index],
                              ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
