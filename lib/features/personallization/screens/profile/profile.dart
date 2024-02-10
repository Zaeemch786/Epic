import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/common/widgets/images/circular_images.dart';
import 'package:ecommerce_app/common/widgets/shimmers/t_shimmer_effect.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/authantication/controllers/usercontroller/user_controller.dart';
import 'package:ecommerce_app/features/personallization/screens/profile/widgets/change_name.dart';
import 'package:ecommerce_app/features/personallization/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
        appBar: const TAppBar(
          showbackArrow: true,
          title: Text('profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : "assets/images/user.png";

                        return controller.imageUploading.value
                            ? const TShimmerEffect(
                                width: 80,
                                height: 80,
                                radius: 80,
                              )
                            : TcircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      }),
                      TextButton(
                          onPressed: () =>
                              controller.uploadUserProfilePicture(),
                          child: const Text('chage profile Picture'))
                    ],
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const TSectionHadding(
                  title: 'Profile Information',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TProfileMenu(
                  onPresses: () => Get.to(() => const ChangeName()),
                  title: 'Name',
                  value: controller.user.value.fullName,
                ),
                TProfileMenu(
                  onPresses: () {},
                  title: 'Username',
                  value: controller.user.value.username,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                const TSectionHadding(
                  title: 'Personal Information',
                  showActionButton: false,
                ),
                TProfileMenu(
                  onPresses: () {},
                  title: "User ID",
                  value: controller.user.value.id,
                  icon: Iconsax.copy,
                ),
                TProfileMenu(
                    onPresses: () {},
                    title: 'E-mail',
                    value: controller.user.value.email),
                TProfileMenu(
                    onPresses: () {},
                    title: 'Phone Number',
                    value: controller.user.value.phoneNumber),
                TProfileMenu(onPresses: () {}, title: 'Gender', value: 'Male'),
                TProfileMenu(
                    onPresses: () {},
                    title: 'Date od Birth',
                    value: '15 Nov, 2002'),
                const Divider(),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Center(
                  child: TextButton(
                      onPressed: () => controller.deleteAccountWarningPopup(),
                      child: const Text(
                        'Close Account',
                        style: TextStyle(color: Colors.red),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
