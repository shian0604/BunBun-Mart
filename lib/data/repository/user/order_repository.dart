import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ✅ Save order to Firestore
  Future<void> saveOrder(OrderModel order) async {
    try {
      await _db.collection("Orders").doc(order.orderId).set(order.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving the order.';
    }
  }

  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection("Orders")
              .doc(orderId)
              .get();

      if (!doc.exists) {
        throw 'Order not found';
      }

      return OrderModel.fromSnapshot(doc);
    } catch (e) {
      throw 'Failed to fetch order: $e';
    }
  }

  /// ✅ Fetch order by order ID
  Future<OrderModel> fetchOrderById(String orderId) async {
    try {
      final documentSnapshot =
          await _db.collection("Orders").doc(orderId).get();

      if (documentSnapshot.exists) {
        return OrderModel.fromSnapshot(documentSnapshot);
      } else {
        throw 'Order not found.';
      }
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching the order.';
    }
  }

  /// ✅ Fetch orders by seller ID
  Future<List<OrderModel>> fetchOrdersBySellerId(String sellerId) async {
    try {
      if (sellerId.isEmpty) {
        throw 'Invalid Seller ID.';
      }

      final querySnapshot =
          await _db
              .collection("Orders")
              .where("sellerId", isEqualTo: sellerId)
              .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching orders.';
    }
  }

  /// 🔄 Update order status in Firestore
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      final orderRef = _db.collection("Orders").doc(orderId);

      // Ensure order exists
      final docSnapshot = await orderRef.get();
      if (!docSnapshot.exists) {
        throw 'Order not found.';
      }

      // Update order status
      await orderRef.update({"orderStatus": newStatus});
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while updating the order status.';
    }
  }

  /// ❌ Cancel and remove an order by order ID
  Future<void> cancelOrderById(String orderId) async {
    try {
      final docRef = _db.collection("Orders").doc(orderId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw 'Order with ID $orderId not found.';
      }

      await docRef.delete();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while cancelling the order.';
    }
  }

  /// ✅ Fetch orders by current user ID
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;

      if (userId == null) {
        throw 'User not logged in.';
      }

      final querySnapshot =
          await _db
              .collection("Orders")
              .where("userId", isEqualTo: userId)
              .get();

      return querySnapshot.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching orders.';
    }
  }
}
