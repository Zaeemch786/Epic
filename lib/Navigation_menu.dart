// ignore_for_file: file_names

import 'package:ecommerce_app/features/authantication/controllers/navigation_controller.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenuBar extends StatelessWidget {
  NavigationMenuBar({super.key});
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              backgroundColor: darkMode ? TColors.black : Colors.white,
              indicatorColor: darkMode
                  ? TColors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              onDestinationSelected: (index) =>
                  controller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
                NavigationDestination(icon: Icon(Iconsax.shop), label: "Store"),
                NavigationDestination(
                    icon: Icon(Iconsax.heart), label: "Whishlist"),
                NavigationDestination(
                    icon: Icon(Iconsax.user), label: "Profile"),
              ])),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}
