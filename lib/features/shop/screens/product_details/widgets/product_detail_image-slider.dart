import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/images/round_images.dart';
import 'package:ecommerce_app/common/widgets/product/favourite_icon/favourite_icon.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/product/product_controller.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widgets/t_curved_edges_widget.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
    required this.product,
  });
  final CategoryModel product;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return TCurvedEdgesWidget(
        child: Container(
      color: darkMode ? TColors.darkGrey : TColors.light,
      child: Stack(
        children: [
          SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargrdImage(image),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: TColors.primary,
                              )),
                    );
                  }),
                ),
              )),
          Positioned(
            right: 0,
            bottom: 30,
            left: TSizes.defaultSpace,
            child: SizedBox(
              height: 80,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(
                  width: TSizes.spaceBtwItems,
                ),
                itemCount: images.length,
                itemBuilder: (_, index) => Obx(() {
                  final imageSelected =
                      controller.selectedProductImage.value == images[index];
                  return TRoundedImage(
                      width: 80,
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      backgroundColor: darkMode ? TColors.dark : TColors.white,
                      border: Border.all(
                          color: imageSelected
                              ? TColors.primary
                              : Colors.transparent),
                      isNetworkImage: true,
                      imageUrl: images[index]);
                }),
              ),
            ),
          ),
          TAppBar(
            showbackArrow: true,
            actions: [
              TFavouriteIcon(
                productId: product.id,
              )
            ],
          )
        ],
      ),
    ));
  }
}
