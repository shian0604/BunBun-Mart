import 'package:cloud_firestore/cloud_firestore.dart';
import 'product_model.dart';

class CartModel {
  final String cartItemId;
  final String userId;
  final String sellerId;
  final String productId;
  final String productName;
  final double totalPrice;
  final String productImage;
  final int quantity;
  final String selectedSize;
  final String selectedColor;
  final Timestamp timestamp;
  bool selected;

  CartModel({
    required this.cartItemId,
    required this.userId,
    required this.sellerId,
    required this.productId,
    required this.productName,
    required this.totalPrice,
    required this.productImage,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
    required this.timestamp,
    required this.selected,
  });

  /// ✅ copyWith method
  CartModel copyWith({
    String? cartItemId,
    String? userId,
    String? sellerId,
    String? productId,
    String? productName,
    double? totalPrice,
    String? productImage,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
    Timestamp? timestamp,
    bool? selected,
  }) {
    return CartModel(
      cartItemId: cartItemId ?? this.cartItemId,
      userId: userId ?? this.userId,
      sellerId: sellerId ?? this.sellerId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      totalPrice: totalPrice ?? this.totalPrice,
      productImage: productImage ?? this.productImage,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      timestamp: timestamp ?? this.timestamp,
      selected: selected ?? this.selected,
    );
  }

  static CartModel fromProduct({
    required String cartItemId,
    required String userId,
    required ProductModel product,
    required int quantity,
    required String selectedSize,
    required String selectedColor,
  }) {
    return CartModel(
      cartItemId: cartItemId,
      userId: userId,
      sellerId: product.sellerId,
      productId: product.productId,
      productName: product.productName,
      totalPrice: product.productPrice * quantity,
      productImage:
          product.productImages.isNotEmpty ? product.productImages.first : '',
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
      timestamp: Timestamp.now(),
      selected: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'userId': userId,
      'sellerId': sellerId,
      'productId': productId,
      'productName': productName,
      'totalPrice': totalPrice,
      'productImage': productImage,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'timestamp': timestamp,
      'selected': selected,
    };
  }

  factory CartModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return CartModel(
      cartItemId: document.id,
      userId: data['userId'] ?? '',
      sellerId: data['sellerId'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
      productImage: data['productImage'] ?? '',
      quantity: data['quantity'] ?? 1,
      selectedSize: data['selectedSize'] ?? '',
      selectedColor: data['selectedColor'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      selected: data['selected'] ?? false,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> data) {
    return CartModel(
      cartItemId: data['cartItemId'] ?? '',
      userId: data['userId'] ?? '',
      sellerId: data['sellerId'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
      productImage: data['productImage'] ?? '',
      quantity: data['quantity'] ?? 1,
      selectedSize: data['selectedSize'] ?? '',
      selectedColor: data['selectedColor'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      selected: data['selected'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Selected Size: $selectedSize, Selected Color: $selectedColor';
  }
}
