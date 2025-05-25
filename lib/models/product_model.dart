import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String sellerId;
  String storeName;
  String profilePicture;
  final String productId;
  final String productName;
  final String productCategory;
  final double productPrice;
  int productStocks;
  final List<String> productSizes;
  final List<String> productColors;
  final String productDescription;
  List<String> productImages;

  ProductModel({
    required this.sellerId,
    required this.storeName,
    required this.profilePicture,
    required this.productId,
    required this.productName,
    required this.productCategory,
    required this.productPrice,
    required this.productStocks,
    required this.productSizes,
    required this.productColors,
    required this.productDescription,
    required this.productImages,
  });

  static ProductModel empty() => ProductModel(
    sellerId: '',
    storeName: '',
    profilePicture: '',
    productId: '',
    productName: '',
    productCategory: '',
    productPrice: 0.0,
    productStocks: 0,
    productSizes: [],
    productColors: [],
    productDescription: '',
    productImages: [],
  );

  // Convert a ProductModel into a map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'sellerId': sellerId,
      'storeName': storeName,
      'profilePicture': profilePicture,
      'productId': productId,
      'productName': productName,
      'productCategory': productCategory,
      'productPrice': productPrice,
      'productStocks': productStocks,
      'productSizes': productSizes,
      'productColors': productColors,
      'productDescription': productDescription,
      'productImages': productImages,
    };
  }

  // Create a ProductModel from a Firestore document snapshot
  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return ProductModel(
        sellerId: data['sellerId'] ?? '',
        storeName: data['storeName'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        productId: document.id,
        productName: data['productName'] ?? '',
        productCategory: data['productCategory'] ?? '',
        productPrice: (data['productPrice'] ?? 0.0).toDouble(),
        productStocks: data['productStocks'] ?? 0,
        productSizes: List<String>.from(data['productSizes'] ?? []),
        productColors: List<String>.from(data['productColors'] ?? []),
        productDescription: data['productDescription'] ?? '',
        productImages: List<String>.from(data['productImages'] ?? []),
      );
    } else {
      return ProductModel.empty();
    }
  }
}
