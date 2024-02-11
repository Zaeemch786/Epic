import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/product/ratings/rating_indicator.dart';
import 'package:ecommerce_app/features/authantication/controllers/authentication_controller.dart';
import 'package:ecommerce_app/features/shop/screens/product_rewiews/widgets/overall_product_rating.dart';
import 'package:ecommerce_app/features/shop/screens/product_rewiews/widgets/user_review_cart.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Text('Reviews & Ratings'),
        showbackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that  you use.'),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TOverallProductRating(),
              const TRatingBarIndicator(
                ratings: 3.5,
              ),
              Text(
                '12,611',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const UserReviewCard(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  // controller: msgController,
                  decoration: InputDecoration(
                      hintText: "Write Something on the Wall...",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        // postMessage,
                        icon: Icon(
                          Icons.send,
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Theme.of(context).colorScheme.primary,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary))),
                ),
              ),
              Text('Logged in as: ' +
                  AuthenticationRepository.instance.authUser!.email!),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
