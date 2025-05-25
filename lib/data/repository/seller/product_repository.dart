import 'package:bunbunmart/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:bunbunmart/data/repository/exceptions/bun_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save product data to Firestore under the current seller's ID.
  Future<void> saveProductRecord(String sellerId, ProductModel product) async {
    try {
      await _db
          .collection("Sellers")
          .doc(sellerId)
          .collection("Products")
          .doc(product.productId)
          .set(product.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to get all products for a specific seller.
  Future<List<ProductModel>> fetchProductsBySellerId(String sellerId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db
              .collection("Sellers")
              .doc(sellerId)
              .collection("Products")
              .get();

      List<ProductModel> products = [];

      for (var doc in querySnapshot.docs) {
        ProductModel product = ProductModel.fromSnapshot(
          doc,
        ); // doc is now of correct type
        product.productImages = await _fetchImageUrlsFromSupabase(
          sellerId,
          product.productId,
        );
        products.add(product);
      }

      return products;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Helper function to fetch image URLs from Supabase
  Future<List<String>> _fetchImageUrlsFromSupabase(
    String sellerId,
    String productId,
  ) async {
    final storage = Supabase.instance.client.storage;
    final folderPath = '$sellerId/$productId';
    final List<String> imageUrls = [];

    try {
      final response = await storage
          .from('product-images')
          .list(path: folderPath);

      for (var file in response) {
        final publicUrl = storage
            .from('product-images')
            .getPublicUrl('$folderPath/${file.name}');
        imageUrls.add(publicUrl);
      }
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }

    return imageUrls;
  }

  /// Pass selected product for editing (only one allowed)
  Future<ProductModel?> getSelectedProductForEdit(
    List<String> selectedProductIds,
    String sellerId,
  ) async {
    if (selectedProductIds.length != 1) {
      return null; // Exceeds 1, editing not allowed
    }

    try {
      final doc =
          await _db
              .collection("Sellers")
              .doc(sellerId)
              .collection("Products")
              .doc(selectedProductIds.first)
              .get();

      if (doc.exists) {
        ProductModel product = ProductModel.fromSnapshot(doc);
        product.productImages = await _fetchImageUrlsFromSupabase(
          sellerId,
          product.productId,
        );
        return product;
      }
      return null;
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to save product data to Firestore under the current seller's ID.
  Future<void> updateProductStock(
    String sellerId,
    String productId,
    int newQuantity,
  ) async {
    try {
      // Step 1: Get the product document snapshot
      final docSnapshot =
          await FirebaseFirestore.instance
              .collection("Sellers")
              .doc(sellerId)
              .collection("Products")
              .doc(productId)
              .get();

      // Step 2: Check if the product exists
      if (docSnapshot.exists) {
        // Step 3: Convert snapshot to ProductModel
        final product = ProductModel.fromSnapshot(docSnapshot);

        // Step 4: Update the stock value in the model
        product.productStocks = newQuantity;

        // Step 5: Save the updated product model
        await saveProductRecord(sellerId, product);
      } else {
        print("Product not found");
      }
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Save updated product data
  Future<void> updateProduct(
    String sellerId,
    ProductModel updatedProduct,
  ) async {
    try {
      await _db
          .collection("Sellers")
          .doc(sellerId)
          .collection("Products")
          .doc(updatedProduct.productId)
          .update(updatedProduct.toJson());
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Delete selected products by ID
  Future<void> deleteSelectedProducts(
    String sellerId,
    List<String> selectedProductIds,
  ) async {
    WriteBatch batch = _db.batch();
    final storage = Supabase.instance.client.storage;

    try {
      for (String productId in selectedProductIds) {
        final folderPath = '$sellerId/$productId';

        // 1. Fetch all image filenames under the folder
        final files = await storage
            .from('product-images')
            .list(path: folderPath);

        // 2. Delete images if they exist
        if (files.isNotEmpty) {
          final filePaths =
              files.map((file) => '$folderPath/${file.name}').toList();
          await storage.from('product-images').remove(filePaths);
        }

        // 3. Delete product document from Firestore
        DocumentReference ref = _db
            .collection("Sellers")
            .doc(sellerId)
            .collection("Products")
            .doc(productId);

        batch.delete(ref);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw BunFirebaseException(code: e.code).message;
    } on BunFormatException catch (_) {
      throw const FormatException();
    } on BunPlatformException catch (e) {
      throw BunPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  

}
