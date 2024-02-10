import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/container/primary_header_container.dart';
import 'package:ecommerce_app/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/authantication/controllers/usercontroller/user_controller.dart';
import 'package:ecommerce_app/features/personallization/screens/addresses/adresses.dart';
import 'package:ecommerce_app/features/personallization/screens/profile/profile.dart';
import 'package:ecommerce_app/features/shop/screens/cart/cart.dart';
import 'package:ecommerce_app/features/shop/screens/order/order.dart';
import 'package:ecommerce_app/features/shop/screens/setting/widget/setting_menu_tile.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                TAppBar(
                  title: Text(
                    'Account',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),
                TUserProfileTile(
                  onTap: () => Get.to(() => const ProfileScreen()),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),
            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TSectionHadding(
                title: 'Account Setting',
                showActionButton: false,
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
            TSettingMenuTile(
              icon: Iconsax.safe_home,
              title: 'My Adresses',
              subTitle: "Set shopping delivery address",
              onTap: () => Get.to(() => const UserAdressScreen()),
            ),
            TSettingMenuTile(
              icon: Iconsax.shopping_cart,
              title: 'My Cart',
              subTitle: "Add remove product and move to checkout",
              onTap: () => Get.to(const CartScreen()),
            ),
            TSettingMenuTile(
              icon: Iconsax.bag_tick,
              title: 'My Odders',
              subTitle: "In-progress and Completed Orders",
              onTap: () => Get.to(() => const OrderCreen()),
            ),
            TSettingMenuTile(
              icon: Iconsax.bank,
              title: 'Bank Account',
              subTitle: "Withdraw balance to registered bank account",
              onTap: () {},
            ),
            // TSettingMenuTile(
            //   icon: Iconsax.discount_shape,
            //   title: 'My Coupons',
            //   subTitle: "List at all the discounted coupons",
            //   onTap: () {},
            // ),
            // TSettingMenuTile(
            //   icon: Iconsax.notification,
            //   title: 'Notifications',
            //   subTitle: "Set any kind of notifications message",
            //   onTap: () {},
            // ),
            // TSettingMenuTile(
            //   icon: Iconsax.security_card,
            //   title: 'Account Privacy',
            //   subTitle: "Manage data usage and connected accounts",
            //   onTap: () {},
            // ),

            const Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: TSectionHadding(
                title: 'App Settings',
                showActionButton: false,
              ),
            ),

            const TSettingMenuTile(
                icon: Iconsax.document_upload,
                title: 'Load Data',
                subTitle: 'Upload Data to your Cloud Firebase'),
            TSettingMenuTile(
              icon: Iconsax.location,
              title: 'GeoLocation',
              subTitle: 'Set recommendation based on Location',
              trailing: Obx(
                () => Switch(
                    value: controller.switchValue.value,
                    onChanged: (value) {
                      controller.switchValue.value = value;
                    }),
              ),
            ),
            // TSettingMenuTile(
            //   icon: Iconsax.security_user,
            //   title: 'Safe Mode',
            //   subTitle: 'Search result is safe for all ages',
            //   trailing: Switch(value: false, onChanged: (value) {}),
            // ),
            // TSettingMenuTile(
            //   icon: Iconsax.image,
            //   title: 'HD Image Quality',
            //   subTitle: 'Set Image Quality to be seen',
            //   trailing: Obx(
            //     () => Switch(
            //         value: controller.switchValue.value,
            //         onChanged: (value) {
            //           controller.switchValue.value = value;
            //         }),
            //   ),
            // ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => controller.logoutWarningPopup(),
                  child: const Text('Logout')),
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections * 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
