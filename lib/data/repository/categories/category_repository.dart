import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:bunbunmart/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //Variables
  final _db = FirebaseFirestore.instance;

  //Get all Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Category').get();
      final list =
          snapshot.docs
              .map((document) => CategoryModel.fromSnapshot(document))
              .toList();
      return list;
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
