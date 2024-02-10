import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/brands/brand_cart.dart';
import 'package:ecommerce_app/common/widgets/layouts/gird_layout.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/screens/brand/brand_product.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  const AllBrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Brand'),
        showbackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          // ignore: prefer_const_constructors
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TSectionHadding(title: 'Brands'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TGridLayout(
                  itemCount: 10,
                  mainAxisextent: 80,
                  itemBuilder: (context, index) => TBrandCard(
                        showBorder: true,
                        onTap: () => Get.to(() => const BrandProduct()),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
