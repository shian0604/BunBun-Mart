import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final String sellerId;
  final String address;
  final DateTime deliveryDate;
  final List<CartModel> items;
  final DateTime orderDate;
  final String paymentMethod;
  final String orderStatus;
  final double totalAmount;
  final String shippingMethod;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.sellerId,
    required this.address,
    required this.deliveryDate,
    required this.items,
    required this.orderDate,
    required this.paymentMethod,
    required this.orderStatus,
    required this.totalAmount,
    required this.shippingMethod,
  });

  /// ✅ Convert OrderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'sellerId': sellerId,
      'address': address,
      'deliveryDate': Timestamp.fromDate(deliveryDate),
      'items': items.map((item) => item.toJson()).toList(),
      'orderDate': Timestamp.fromDate(orderDate),
      'paymentMethod': paymentMethod,
      'orderStatus': orderStatus,
      'totalAmount': totalAmount,
      'shippingMethod': shippingMethod,
    };
  }

  /// ✅ Create OrderModel from Firestore snapshot
  factory OrderModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return OrderModel(
      orderId: document.id,
      userId: data['userId'],
      sellerId: data['sellerId'],
      address: data['address'],
      deliveryDate: (data['deliveryDate'] as Timestamp).toDate(),
      items:
          (data['items'] as List<dynamic>)
              .map(
                (item) => CartModel.fromJson(Map<String, dynamic>.from(item)),
              )
              .toList(),

      orderDate: (data['orderDate'] as Timestamp).toDate(),
      paymentMethod: data['paymentMethod'],
      orderStatus: data['orderStatus'],
      totalAmount: (data['totalAmount'] as num).toDouble(),
      shippingMethod: data['shippingMethod'],
    );
  }

  /// ✅ Returns a string of all product names like: "Product 1, & Product 2"
  String get mergedProductNames {
    if (items.isEmpty) return '';

    final productNames = items.map((item) => item.productName).toList();

    if (productNames.length == 1) {
      return productNames.first;
    }

    final allExceptLast = productNames
        .sublist(0, productNames.length - 1)
        .join(', ');
    final last = productNames.last;
    return '$allExceptLast, & $last';
  }
}
