import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/seller_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SellerRepository extends GetxController {
  static SellerRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save seller data to Firestore.
  Future<void> saveSellerRecord(SellerModel seller) async {
    try {
      await _db.collection("Sellers").doc(seller.id).set(seller.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to fetch seller details from Firestore
  Future<SellerModel> fetchSellerDetails() async {
    try {
      final documentSnapshot =
          await _db
              .collection("Sellers")
              .doc(AuthenticationRepository.instance.authUser?.uid)
              .get();

      if (documentSnapshot.exists) {
        return SellerModel.fromSnapshot(documentSnapshot);
      } else {
        return SellerModel.empty();
      }
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  Future<SellerModel> fetchSellerData(String sellerId) async {
    final doc = await _db.collection("Sellers").doc(sellerId).get();
    if (doc.exists) {
      return SellerModel.fromSnapshot(doc);
    } else {
      throw Exception("Seller not found");
    }
  }

  /// Update full seller details in Firestore
  Future<void> updateSellerDetails(SellerModel updatedSeller) async {
    try {
      await _db
          .collection("Sellers")
          .doc(updatedSeller.id)
          .update(updatedSeller.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Update a single field in Seller document
  Future<void> updateSingleSellerField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Sellers")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Remove seller document from Firestore
  Future<void> removeSellerRecord(String sellerId) async {
    try {
      await _db.collection("Sellers").doc(sellerId).delete();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
