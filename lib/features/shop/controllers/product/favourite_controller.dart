import 'dart:convert';

import 'package:ecommerce_app/data/respositories/categories/category_repository.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/utills/local_storage/storage_utility.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  /// Variables
  final favourite = <String, bool>{}.obs;
  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  void initFavorites() {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storageFavourite = jsonDecode(json) as Map<String, dynamic>;
      favourite.assignAll(
          storageFavourite.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourite[productId] ?? false;
  }

  void toogleFavouriteProduct(String productId) {
    if (!favourite.containsKey(productId)) {
      favourite[productId] = true;
      saveFavouriteToStorage();
      TFullScreenLoader.customToast(
          message: 'Product has been added to the WhishList.');
    } else {
      TLocalStorage.instance().removeData(productId);
      favourite.remove(productId);
      saveFavouriteToStorage();
      favourite.refresh();
      TFullScreenLoader.customToast(
          message: 'Product has been remove from the WhishList.');
    }
  }

  void saveFavouriteToStorage() {
    final encoedfavourites = jsonEncode(favourite);
    TLocalStorage.instance().saveData('favorites', encoedfavourites);
  }

  Future<List<CategoryModel>> favoriteProducts() async {
    return await CategoryPepository.instance
        .getFauoriteProducts(favourite.keys.toList());
  }
}
