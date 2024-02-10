import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isfeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isfeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });
  static ProductModel empty() => ProductModel(
      id: '', title: '', stock: 0, price: 0, thumbnail: '', productType: '');
  toJson() {
    return {
      'Sku': sku,
      'title': title,
      'stock': stock,
      'price': price,
      'Images': images ?? [],
      'thumbnail': thumbnail,
      'salePrice': salePrice,
      'IsFeatured': isfeatured,
      'categoryId': categoryId,
      'brand': brand!.toJson(),
      'description': description,
      'productType': productType,
      'productAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'productVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : []
    };
  }

  factory ProductModel.fromSnaoshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
        id: document.id,
        title: data['title'],
        sku: data['Sku'],
        stock: data['stock'] ?? 0,
        price: double.parse((data['price'] ?? 0.0).toString()),
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        thumbnail: data['thumbnail'] ?? '',
        categoryId: data['categoryId'] ?? '',
        description: data['description'] ?? '',
        productType: data['productType'] ?? '',
        isfeatured: data['IsFeatured'] ?? false,
        brand: BrandModel.fromJson(data['brand']),
        images: data['Images'] != null ? List<String>.from(data['Images']) : [],
        productAttributes: (data['productAttributes'] as List<dynamic>)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList(),
        productVariations: (data['productVariations'] as List<dynamic>)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList());
  }
}

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productCount;
  BrandModel(
      {required this.id,
      required this.image,
      required this.name,
      this.isFeatured,
      this.productCount});
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');
  toJson() {
    return {
      "Id": id,
      "name": name,
      "image": image,
      "productCount": productCount,
      "isFeatured": isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? "",
        image: data['image'] ?? "",
        name: data['name'] ?? "");
  }
}

class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({
    this.name,
    this.values,
  });
  toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}

class ProductVariationModel {
  String id;
  String sku;
  String image;
  String? description;
  double? price;
  double? salePrice;
  int? stock;
  Map<String, String> attributesValues;
  ProductVariationModel({
    required this.id,
    required this.attributesValues,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
  });
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributesValues: {});
  toJson() {
    return {
      "Id": id,
      "description": description,
      "image": image,
      "price": price,
      "salePrice": salePrice,
      "sku": sku,
      "stock": stock,
      "attributesValues": attributesValues,
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['Id'] ?? "",
        image: data['image'] ?? "",
        sku: data['sku'] ?? "",
        description: data['description'] ?? "",
        stock: data['stock'] ?? 0,
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        price: double.parse((data['price'] ?? 0.0).toString()),
        attributesValues: Map<String, String>.from(data['attributesValues']));
  }
}
