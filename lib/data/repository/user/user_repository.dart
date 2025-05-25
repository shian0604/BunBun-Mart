import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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

  //Function to fetch user details based on user ID
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot =
          await _db
              .collection("Users")
              .doc(AuthenticationRepository.instance.authUser?.uid)
              .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on BunFirebaseAuthException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Function to update user data in FireStore
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BunFormatException();
    } on PlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  //Update any field in specific Users Collection - Single Field
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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

  //Function to remove user data from FireStore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
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

  //Uploaded any Image {Supabase}
}
