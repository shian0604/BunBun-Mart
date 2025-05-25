import 'dart:typed_data';
import 'package:bunbunmart/data/controller/seller/product_controller.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show FileOptions, Supabase;

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final productController = ProductController.instance;
  final productRepository = ProductRepository.instance;

  GlobalKey<FormState> editProductFormKey = GlobalKey<FormState>();

  late ProductModel existingProduct;
  final RxBool isLoading = false.obs;

  /// Initialize the fields with existing product data
  final RxList<String> existingImageUrls = <String>[].obs;
  final RxList<Uint8List> newSelectedImages = <Uint8List>[].obs;

  void initializeProductData(ProductModel product) {
    existingProduct = product;
    productController.productName.text = product.productName;
    productController.productPrice.text = product.productPrice.toString();
    productController.productStocks.text = product.productStocks.toString();
    productController.productDescription.text = product.productDescription;
    productController.selectedCategory.value = product.productCategory;

    productController.selectedSizes.assignAll(product.productSizes);
    productController.selectedColors.assignAll(product.productColors);
    existingImageUrls.assignAll(product.productImages);
  }

  void deleteExistingImage(String imageUrl) async {
    existingImageUrls.remove(imageUrl);

    final uri = Uri.parse(imageUrl);
    final filename = uri.pathSegments.last;
    final folderPath =
        '${FirebaseAuth.instance.currentUser!.uid}/${existingProduct.productId}';
    final filePath = '$folderPath/$filename';

    try {
      await Supabase.instance.client.storage.from('product-images').remove([
        filePath,
      ]);
    } catch (e) {
      print("Error deleting image from Supabase: $e");
    }
  }

  Future<List<String>> replaceProductImages(
    List<Uint8List> newImages,
    String productId,
    List<String> oldImageUrls,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("You're not logged in!");

    final String sellerId = user.uid;

    final storage = Supabase.instance.client.storage;
    final folderPath = '$sellerId/$productId';

    // Combine existing + new count check
    final totalImages = existingImageUrls.length + newImages.length;
    if (totalImages > 5) {
      throw Exception(
        "You can only upload a total of 5 images (existing + new).",
      );
    }

    try {
      BunLoader.openLoadingDialog("Uploading new product images... 🐰");

      final List<String> combinedImageUrls = [...existingImageUrls];

      for (int i = 0; i < newImages.length; i++) {
        final filePath = '$folderPath/image_${combinedImageUrls.length}.png';

        await storage
            .from('product-images')
            .uploadBinary(
              filePath,
              newImages[i],
              fileOptions: const FileOptions(
                contentType: 'image/png',
                upsert: true,
                cacheControl: '3600',
              ),
            );

        final publicUrl = storage.from('product-images').getPublicUrl(filePath);
        combinedImageUrls.add(publicUrl);
      }

      BunLoader.stopLoading();
      return combinedImageUrls;
    } catch (e) {
      BunLoader.stopLoading();
      throw Exception("Image upload failed: $e");
    }
  }

  /// Update product in Firestore
  Future<void> updateProductData({List<Uint8List>? newImages}) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(title: "Uh-oh!", message: "Not logged in.");
        return;
      }

      String sellerId = user.uid;
      final seller = await SellerRepository.instance.fetchSellerData(sellerId);

      BunLoader.openLoadingDialog("Updating your product...");

      if (!await NetworkManager.instance.isConnected()) {
        BunLoader.stopLoading();
        return;
      }

      if (!editProductFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      if (productController.selectedCategory.value.isEmpty ||
          productController.selectedSizes.isEmpty ||
          productController.selectedColors.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Wait! 🐾",
          message: "Please fill all required fields.",
        );
        return;
      }

      List<String> finalImageUrls = existingProduct.productImages;
      if (newSelectedImages.isNotEmpty) {
        final newUrls = await replaceProductImages(
          newSelectedImages,
          existingProduct.productId,
          existingProduct.productImages,
        );
        finalImageUrls = newUrls;
      } else {
        finalImageUrls = existingImageUrls;
      }

      if (finalImageUrls.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Missing Images 🖼️",
          message: "Please add at least one product image before updating.",
        );
        return;
      }

      print("🛠️ newSelectedImages length: ${newSelectedImages.length}");

      final updatedProduct = ProductModel(
        sellerId: sellerId,
        storeName: seller.storeName,
        profilePicture: seller.profilePicture,
        productId: existingProduct.productId,
        productName: productController.productName.text.trim(),
        productPrice: double.parse(productController.productPrice.text.trim()),
        productStocks: int.parse(productController.productStocks.text.trim()),
        productCategory: productController.selectedCategory.value,
        productSizes: productController.selectedSizes.toList(),
        productColors: productController.selectedColors.toList(),
        productDescription: productController.productDescription.text.trim(),
        productImages: finalImageUrls,
      );

      await productRepository.updateProduct(sellerId, updatedProduct);

      BunLoader.stopLoading();
      BunSnackBar.bunsuccess(
        title: "Product Updated! 🎉",
        message: "Images and product info updated successfully!",
      );

      Get.off(() => const SellerMainPage(selectedIndex: 0));

      clearEditFields();
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(title: "Update failed 🐾", message: e.toString());
    }
  }

  /// Clears all edit form fields and resets values
  void clearEditFields() {
    // Clear all text controllers from ProductController
    productController.productName.clear();
    productController.productPrice.clear();
    productController.productStocks.clear();
    productController.productDescription.clear();
    productController.customColorController.clear();

    // Reset selections
    productController.selectedCategory.value = '';
    productController.selectedSizes.clear();
    productController.selectedColors.clear();

    // Clear local edit controller state
    existingImageUrls.clear();
    newSelectedImages.clear();
  }
}
