import 'package:ecommerce_app/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce_app/features/shop/models/cart_item_model.dart';
import 'package:ecommerce_app/features/shop/models/category_model.dart';
import 'package:ecommerce_app/utills/local_storage/storage_utility.dart';
import 'package:ecommerce_app/utills/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  void addToCart(CategoryModel product) {
    if (productQuantityInCart.value > 1) {
      TFullScreenLoader.customToast(message: 'Selected Quantity');
      return;
    }
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TFullScreenLoader.customToast(message: 'Selected Variation');
      return;
    }
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock! < 1) {
        TFullScreenLoader.warningSnakBar(
            title: 'Oh Snap!', message: 'Selected variation is out of stock.');
      } else {
        if (product.stock < 1) {
          TFullScreenLoader.warningSnakBar(
              title: 'Oh Snap!',
              message: 'Selected variation is out of stock.');
          return;
        }
      }
      final selectedCartItem =
          converToCartItem(product, productQuantityInCart.value);
      int index = cartItems.indexWhere((element) =>
          element.productId == selectedCartItem.productId &&
          element.variationId == selectedCartItem.variationId);
      if (index >= 0) {
        cartItems[index].quantity = selectedCartItem.quantity;
      } else {
        cartItems.add(selectedCartItem);
      }
      updateCart();
      TFullScreenLoader.customToast(
          message: 'Your Product has been added to the Cart');
    }
  }

  void addonetoCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
    TFullScreenLoader.customToast(
        message: 'Your Product has been added to the Cart');
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartitem) =>
        cartitem.productId == item.productId &&
        cartitem.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeOneFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeOneFromCartDialog(int index) {
    Get.defaultDialog(
        title: 'Remove Product',
        middleText: 'Are you sure you want to remove this product?',
        onConfirm: () {
          cartItems.removeAt(index);
          updateCart();
          TFullScreenLoader.customToast(
              message: 'Product removed from the Cart');
          Get.back();
        },
        onCancel: () => () => Get.back());
  }

  void updateAlreadyAddedProductCount(CategoryModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value;
      }
    }
  }

  CartItemModel converToCartItem(CategoryModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isvariation = variation.id.isNotEmpty;
    final price = isvariation
        ? variation.salePrice! > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;
    return CartItemModel(
        productId: product.id,
        quantity: quantity,
        price: price!,
        title: product.title!,
        variationId: variation.id,
        image: isvariation ? variation.image : product.image,
        brandName: product.name,
        selectedVariation: isvariation ? variation.attributesValues : null);
  }

  void updateCart() {
    updateCartTotals();
    saveCartTotals();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfItems = 0;
    for (var item in cartItems) {
      calculateTotalPrice += (item.price) * item.quantity.toDouble();
      calculateNoOfItems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfItems;
  }

  void saveCartTotals() {
    final cartitemStrings = cartItems.map((item) => item.toJson()).toList();
    TLocalStorage.instance().saveData('cartItems', cartitemStrings);
  }

  void loadCartItems() {
    final cartitemStrings =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartitemStrings != null) {
      cartItems.assignAll(cartitemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
