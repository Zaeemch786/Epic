import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();
  RxMap selectedArrtributes = {}.obs;
  Rx<ProductVariationModels> selectedVariation =
      ProductVariationModels.empty().obs;
  // void onArttributSelectedd(
  //     CategoryModel product, arttributesName, attributeValue) {
  //   final selectedAyyributes =
  //       Map<String, dynamic>.from(this.selectedArrtributes);
  //   selectedArrtributes[arttributesName] = attributeValue;
  //   this.selectedArrtributes[arttributesName] = attributeValue;

  //   final selectedVariation = product.productVariations!.firstWhere(
  //       (variation) => _isSameAttributesValues(
  //           variation.attributesValues, selectedAyyributes),
  //       orElse: () => ProductVariationModels.empty());

  //   if (selectedVariation.image.isNotEmpty) {
  //     ImageController.instance.SelectedProductImage.value =
  //         selectedVariation.image;
  //   }
  //   if(selectedVariation.id.isNotEmpty){

  //   }
  //   this.selectedVariation.value = selectedVariation;

  // }
  // bool _isSameAttributesValues(Map<String,dynamic> variationAttributes,Map<String,dynamic>selectedAttributes){
  //   if (variationAttributes.length ! = selectedAttributes.length) return false;

  //     for (var key in variationAttributes.length) {
  //       if (variationAttributes[key] != selectedAttributes[key]) return false;

  //     }

  // }

  void resetSelectedAttributes() {
    selectedArrtributes.clear();
    selectedVariation.value = ProductVariationModels.empty();
  }
}
