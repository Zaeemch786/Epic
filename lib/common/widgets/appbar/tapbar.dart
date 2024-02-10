import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/device/device_utillity.dart';
import 'package:ecommerce_app/utills/helpers/helpers_functions.dart';
import 'package:flutter/material.dart';

class TTapbBar extends StatelessWidget implements PreferredSizeWidget {
  const TTapbBar({super.key, required this.tabs});
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
        color: dark ? TColors.black : TColors.white,
        child: TabBar(
          tabs: tabs,
          isScrollable: true,
          indicatorColor: TColors.primary,
          labelColor: dark ? TColors.white : TColors.primary,
          unselectedLabelColor: TColors.darkGrey,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
