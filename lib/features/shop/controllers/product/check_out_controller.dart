import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/models/payment_method_model.dart';
import 'package:ecommerce_app/features/shop/screens/Checkout/widgets/t_payment_tile.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutController extends GetxController {
  static CheckOutController get instance => Get.find();

  final Rx<PayMentMethodModel> selectedPaymentMethod =
      PayMentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PayMentMethodModel(
        image: 'assets/icons/cash.png', name: 'Cash On Delivery');
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  children: [
                    const TSectionHadding(
                      title: 'Select Payment Method',
                      showActionButton: false,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/cash.png',
                            name: 'Cash On Delivery')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/easypaisa.png',
                            name: 'EasyPaisa')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/jazz.png', name: 'JazzCash')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    // TPaymentTile(
                    //     payMentMethod: PayMentMethodModel(
                    //         image: 'assets/icons/debit.png',
                    //         name: 'Credit/Debit Card')),
                    // const SizedBox(
                    //   height: TSizes.spaceBtwItems / 2,
                    // ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/visa.png', name: 'Visa')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/money.png',
                            name: 'Master Card')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                    TPaymentTile(
                        payMentMethod: PayMentMethodModel(
                            image: 'assets/icons/debit.png',
                            name: 'Credit Card')),
                    const SizedBox(
                      height: TSizes.spaceBtwItems / 2,
                    ),
                  ],
                ),
              ),
            ));
  }
}
