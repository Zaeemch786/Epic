import 'package:ecommerce_app/data/respositories/categories/category_repository.dart';
import 'package:ecommerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryPepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  get featuredProducts => null;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from data source (Firestore, API, etc)
      final categories = await _categoryRepository.getAllCategories();

      // upload the categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String getProductPrice(CategoryModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        dynamic priceToConsider =
            variation.salePrice! > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  Future<List<CategoryModel>> getSubCategories(
    String categoryId,
  ) async {
    try {
      final subCategories =
          await CategoryPepository.instance.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  // Future<List<CategoryModel>> getCategoryProducts(
  //     {required String categoryId, int limit = 4}) async {
  //   try {
  //     final products = await CategoryPepository.instance
  //         .getProductsForCategory(categoryId: categoryId, limit: limit);
  //     return products;
  //   } catch (e) {
  //     TFullScreenLoader.errorSnakBar(title: 'Oh Snap', message: e.toString());
  //     return [];
  //   }
  // }
}
