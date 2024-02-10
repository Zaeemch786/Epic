import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  String? title;
  bool isFeatured;
  int stock;
  String? sku;
  double price;
  String productType;
  String? description;
  double salePrice;
  List<String>? images;
  List<ProductVariationModels>? productVariations;

  CategoryModel(
      {required this.id,
      this.title,
      required this.name,
      required this.image,
      required this.isFeatured,
      this.parentId = '',
      required this.stock,
      required this.price,
      required this.productType,
      this.salePrice = 0.0,
      this.images,
      this.sku,
      this.description,
      this.productVariations});

  /// Empty Helper Function
  static CategoryModel empty() => CategoryModel(
        id: '',
        name: '',
        image: '',
        isFeatured: false,
        stock: 0,
        price: 0,
        productType: '',
      );

  /// COnvet model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'Title': title,
      'ParrentId': parentId,
      'IsFeatured': isFeatured,
      'Sku': sku,
      'stock': stock,
      'Price': price,
      'Images': images ?? [],
      'ProductType': productType,
      'SalePrice': salePrice,
      'description': description,
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : []
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
          id: document.id,
          title: data['Title'],
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
          description: data['description'] ?? '',
          stock: data['stock'] ?? 0,
          price: double.parse((data['Price'] ?? 0.0).toString()),
          productType: data['ProductType'] ?? '',
          sku: data['Sku'],
          salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
          images:
              data['Images'] != null ? List<String>.from(data['Images']) : [],
          productVariations: (data['productVariations'] as List<dynamic>)
              .map((e) => ProductVariationModels.fromJson(e))
              .toList());
    } else {
      return CategoryModel.empty();
    }
  }
}

class ProductVariationModels {
  String id;
  String sku;
  String image;
  String? description;
  double? price;
  double? salePrice;
  int? stock;
  Map<String, String> attributesValues;

  ProductVariationModels({
    required this.id,
    required this.attributesValues,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
  });
  static ProductVariationModels empty() =>
      ProductVariationModels(id: '', attributesValues: {});
  toJson() {
    return {
      "Id": id,
      "image": image,
      "sku": sku,
      "description": description,
      "price": price,
      "salePrice": salePrice,
      "stock": stock,
      "attributesValues": attributesValues,
    };
  }

  factory ProductVariationModels.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModels.empty();
    return ProductVariationModels(
        id: data['Id'] ?? "",
        image: data['image'] ?? "",
        sku: data['sku'] ?? "",
        description: data['description'] ?? "",
        price: double.parse((data['price'] ?? 0.0).toString()),
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        stock: data['stock'] ?? 0,
        attributesValues: Map<String, String>.from(data['attributesValues']));
  }
}
