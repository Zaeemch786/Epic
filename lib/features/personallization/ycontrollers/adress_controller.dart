import 'package:ecommerce_app/common/widgets/custom_shapes/container/circular_container.dart';
import 'package:ecommerce_app/common/widgets/texts/section_heading.dart';
import 'package:ecommerce_app/features/authantication/controllers/network_manager_controller.dart';
import 'package:ecommerce_app/features/personallization/models/adress_model.dart';
import 'package:ecommerce_app/features/personallization/screens/addresses/widgets/add_new_adresses.dart';
import 'package:ecommerce_app/features/personallization/screens/addresses/widgets/single_adresses.dart';
import 'package:ecommerce_app/features/personallization/ycontrollers/adress_repository.dart';
import 'package:ecommerce_app/utills/constants/images_string.dart';
import 'package:ecommerce_app/utills/constants/sizes.dart';
import 'package:ecommerce_app/utills/helpers/cloud_helper_funstion.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdressController extends GetxController {
  static AdressController get instance => Get.find();
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> adressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final adressRepository = Get.put(AdressRepository());
  final Rx<AdressModel> selectedAdress = AdressModel.empty().obs;
  Future<List<AdressModel>> getallUserAdress() async {
    try {
      final adressess = await adressRepository.fetchUserAdress();
      selectedAdress.value = adressess.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AdressModel.empty());
      return adressess;
    } catch (e) {
      TFullScreenLoader.errorSnakBar(
          title: 'Adress not found', message: e.toString());
      return [];
    }
  }

  Future selectedAddress(AdressModel newSelectedAdress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {
            return false;
          },
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const TCircularContainer());
      if (selectedAdress.value.id.isNotEmpty) {
        await adressRepository.updateSelectedField(
            selectedAdress.value.id, false);
      }
      newSelectedAdress.selectedAddress = true;
      selectedAdress.value = newSelectedAdress;
      await adressRepository.updateSelectedField(selectedAdress.value.id, true);
      Get.back();
    } catch (e) {
      TFullScreenLoader.errorSnakBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  Future addNewAdresses() async {
    try {
      TFullScreenLoader.oprnLoadingDialog(
          'Storing Adress', TImages.diliveredEmailIllustration);
      final isConnected = await NetWorkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (!adressFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
      }
      final adress = AdressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);
      final id = await adressRepository.addAdress(adress);
      adress.id = id;
      await selectedAddress(adress);
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.sucessSnakBar(
          title: 'Congratulations',
          message: 'Your adress has been saved sucessfully.');

      refreshData.toggle();
      resetFormFields();
      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TFullScreenLoader.errorSnakBar(
          title: 'Adress not found', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    street.clear();
    country.clear();
    adressFormKey.currentState?.reset();
  }

  Future<dynamic> selecNewAdressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(TSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TSectionHadding(title: 'Select Address'),
                    FutureBuilder(
                        future: getallUserAdress(),
                        builder: (_, snapshot) {
                          final response =
                              TcloudHelperFunction.checkMultiRecordstate(
                                  snapshot: snapshot);
                          if (response != null) return response;
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => TSingleAdress(
                                  adress: snapshot.data![index],
                                  onTap: () async {
                                    await selectedAddress(
                                        snapshot.data![index]);
                                    Get.back();
                                  }));
                        }),
                    const SizedBox(
                      height: TSizes.defaultSpace * 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const AddNewAdressScreen()),
                          child: const Text('Add new address')),
                    )
                  ],
                ),
              ),
            ));
  }
}
