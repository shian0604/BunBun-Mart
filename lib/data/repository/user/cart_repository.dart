import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save a cart item to Firestore
  Future<void> saveCartItem(CartModel cartItem) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      await _db
          .collection("Users")
          .doc(userId)
          .collection("Cart")
          .doc(cartItem.cartItemId)
          .set(cartItem.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving cart item.';
    }
  }

  /// Get all cart items for current user
  Future<List<CartModel>> getCartItems() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      final snapshot = await _db
          .collection("Users")
          .doc(userId)
          .collection("Cart")
          .get();

      return snapshot.docs
          .map((doc) => CartModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching cart items.';
    }
  }

  /// Remove selected cart items using their IDs
  Future<void> removeSelectedCartItems(List<String> cartItemIds) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not authenticated';

      for (String id in cartItemIds) {
        await _db
            .collection("Users")
            .doc(userId)
            .collection("Cart")
            .doc(id)
            .delete();
      }
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Failed to remove selected cart items.';
    }
  }
}
