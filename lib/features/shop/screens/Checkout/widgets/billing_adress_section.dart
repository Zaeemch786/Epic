import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/personallization/models/adress_model.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/adress_controller.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBillingAdressSection extends StatelessWidget {
  const TBillingAdressSection({super.key, this.adress});
  final AdressModel? adress;

  @override
  Widget build(BuildContext context) {
    final adressController = Get.put(AdressController());
    return Obx(() {
      final place = adressController.selectedAdress.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TSectionHadding(
            title: 'Shipping Adress',
            buttonTitle: 'Change',
            onPressed: () => adressController.selecNewAdressPopup(context),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          adressController.selectedAdress.value.id.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adressController.selectedAdress.value.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Text(
                          adressController.selectedAdress.value.phoneNumber,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_history,
                          color: Colors.grey,
                          size: 16,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        Flexible(
                          child: Text(
                            '${place.street},${place.city},${place.state},${place.postalCode},${place.country}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Text(
                  'Select Address',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
        ],
      );
    });
  }
}
