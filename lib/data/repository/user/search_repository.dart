import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/search_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserSearchRepository extends GetxController {
  static UserSearchRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save a recent search to the user's UserSearch subcollection
  Future<void> saveSearchKeyword(UserSearch search) async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not logged in';

      await _db
          .collection("Users")
          .doc(userId)
          .collection("UserSearch")
          .add(search.toJson());
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

  /// Fetch the user's recent search history
  Future<List<UserSearch>> fetchUserSearchHistory() async {
    try {
      final userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId == null) throw 'User not logged in';

      final querySnapshot = await _db
          .collection("Users")
          .doc(userId)
          .collection("UserSearch")
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => UserSearch.fromSnapshot(doc))
          .toList();
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