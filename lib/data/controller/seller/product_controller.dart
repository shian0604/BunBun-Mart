import 'dart:typed_data';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show FileOptions, StorageException, Supabase;

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // Text controllers for product details
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  final productStocks = TextEditingController();
  final productDescription = TextEditingController();
  final customColorController = TextEditingController();

  final RxString selectedCategory = ''.obs;

  // Lists to hold sizes and colors
  final List<String> productSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> productColors = [
    'red',
    'blue',
    'green',
    'yellow',
    'purple',
    'black',
    'white',
  ];
  final RxSet<String> selectedSizes = <String>{}.obs;
  final RxSet<String> selectedColors = <String>{}.obs;

  // Global key for the product form
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  //Select Category
  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  // Function to add a size to the selected sizes
  void toggleSize(List<String> sizes) {
    selectedSizes.addAll(sizes);
    print('Controller selectedSizes: $selectedSizes');
  }

  // Function to add a color to the selected colors
  void toggleColor(List<String> colors) {
    selectedColors.addAll(colors);
  }

  // Function to add a custom color
  void addCustomColor(BuildContext context) {
    final newColor = customColorController.text.trim().toLowerCase();

    // Check if the input is empty
    if (newColor.isEmpty) return;

    // Check if the color is valid
    if (!InputValidator.cssNamedColors.contains(newColor)) {
      BunSnackBar.bunerror(
        title: "Color doesn't exist",
        message: "Invalid color name: $newColor",
      );
      return;
    }

    // Check if the color already exists
    if (productColors.contains(newColor)) {
      BunSnackBar.bunerror(
        title: "Color already exist",
        message: "Color already in the selection: $newColor",
      );
      return;
    }

    // Add the color
    productColors.add(newColor);
    selectedColors.add(newColor); // Automatically select the new color
    print('Custom color added: $newColor');
    customColorController.clear(); // Clear the text field
  }

  // Function to upload product images
  Future<List<String>> uploadProductImages(
    List<Uint8List> images,
    String productId,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception(
        "Uh-oh! 🐾 You're not logged in. Hop back in to continue your paw-some journey!",
      );
    }

    if (images.isEmpty) {
      throw Exception(
        "Don't forget the glam! 🐶📸 Please add at least one adorable product photo.",
      );
    }
    if (images.length > 5) {
      throw Exception(
        "Too many cuties! 🐰 You can only upload up to 5 lovely photos.",
      );
    }

    final String sellerId = user.uid;
    final List<String> imageUrls = [];
    final storage = Supabase.instance.client.storage;

    try {
      BunLoader.openLoadingDialog("Fluffing up your photos... 🐾✨");

      final folderPath = '$sellerId/$productId';

      for (int i = 0; i < images.length; i++) {
        final filePath = '$folderPath/image_$i.png';

        await storage
            .from('product-images')
            .uploadBinary(
              filePath,
              images[i],
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: true,
              ),
            );

        final publicUrl = storage.from('product-images').getPublicUrl(filePath);
        imageUrls.add(publicUrl);
      }

      BunLoader.stopLoading();
      return imageUrls;
    } on StorageException catch (e) {
      BunLoader.stopLoading();
      throw Exception("Upload failed: ${e.message}");
    } catch (e) {
      BunLoader.stopLoading();
      throw Exception("Unexpected error: $e");
    }
  }

  // Function to save the product
  Future<void> saveProduct(List<Uint8List> images) async {
    try {
      // Start loading
      BunLoader.openLoadingDialog(
        "Sprinkling bun magic... Saving your product! 🐰✨",
      );

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      // Get the current user's ID
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Uh-oh! 🐾",
          message: "Looks like you’re not logged in. Hop back in to continue!",
        );
        return;
      }
      String sellerId = user.uid; // Get the seller ID

      // Form validation
      if (!productFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      // Category check
      if (selectedCategory.value.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Hold up, bunfriend! 🐾",
          message:
              "Pick a paw-some category for your product before we hop ahead!",
        );
        return;
      }

      // Size check
      if (selectedSizes.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Wait a whisker! 🐰",
          message:
              "Choose at least one size so fur babies can find the perfect fit!",
        );
        return;
      }

      // Color check
      if (selectedColors.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Almost there! 🎨",
          message:
              "Add a splash of color to make your product pop for our furry friends!",
        );
        return;
      }

      sellerId = FirebaseAuth.instance.currentUser!.uid;

      final seller = await SellerRepository.instance.fetchSellerData(sellerId);

      // Create a new product model
      final newProduct = ProductModel(
        sellerId: sellerId,
        storeName: seller.storeName,
        profilePicture: seller.profilePicture,
        productId:
            DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
        productName: productName.text.trim(),
        productCategory: selectedCategory.value,
        productPrice: double.tryParse(productPrice.text.trim()) ?? 0.0,
        productStocks: int.tryParse(productStocks.text.trim()) ?? 0,
        productSizes: selectedSizes.toList(),
        productColors: selectedColors.toList(),
        productDescription: productDescription.text.trim(),
        productImages: [], // You can add image handling later
      );

      // Upload images and get URLs // This should be populated with the selected images
      newProduct.productImages = await uploadProductImages(
        images,
        newProduct.productId,
      );

      // Save the product record
      await ProductRepository.instance.saveProductRecord(sellerId, newProduct);

      // Stop loading
      BunLoader.stopLoading();

      // Show success message
      BunSnackBar.bunsuccess(
        title: "Yay! 🎉 Product Saved!",
        message: "Your bun-tastic product has been added successfully! 🌟",
      );

      // Clear the form
      clearForm();
      Get.to(() => const SellerMainPage(selectedIndex: 0));
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(title: "Error! 🐾", message: e.toString());
    }
  }

  // Function to clear the form
  void clearForm() {
    productName.clear();
    selectedCategory.value = '';
    productPrice.clear();
    productStocks.clear();
    productDescription.clear();
    selectedSizes.clear();
    selectedColors.clear();
    customColorController.clear();
  }

  @override
  void onClose() {
    productName.dispose();
    productPrice.dispose();
    productStocks.dispose();
    productDescription.dispose();
    customColorController.dispose();
    super.onClose();
  }
}
