import 'package:ecommerce_app/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce_app/features/personallization/screens/addresses/widgets/add_new_adresses.dart';
import 'package:ecommerce_app/features/personallization/screens/addresses/widgets/single_adresses.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/adress_controller.dart';
import 'package:ecommerce_app/utills/constants/colors.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/cloud_helper_funstion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAdressScreen extends StatelessWidget {
  const UserAdressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdressController());
    return Scaffold(
      appBar: TAppBar(
        showbackArrow: true,
        title: Text(
          'Adresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getallUserAdress(),
                builder: (context, snapshot) {
                  final response = TcloudHelperFunction.checkMultiRecordstate(
                      snapshot: snapshot);
                  if (response != null) return response;
                  final adresses = snapshot.data!;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: adresses.length,
                      itemBuilder: (_, index) => TSingleAdress(
                            adress: adresses[index],
                            onTap: () =>
                                controller.selectedAdress(adresses[index]),
                          ));
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () => Get.to(() => const AddNewAdressScreen()),
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
    );
  }
}
