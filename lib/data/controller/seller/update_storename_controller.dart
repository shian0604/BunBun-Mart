import 'package:bunbunmart/data/controller/seller/seller_controller.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/pages/seller/seller_mainpage.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateStoreNameController extends GetxController {
  static UpdateStoreNameController get instance => Get.find();

  final updatedStoreName = TextEditingController();
  final sellerController = SellerController.instance;
  final sellerRepository = Get.put(SellerRepository());
  GlobalKey<FormState> updateStoreNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeStoreName();
    super.onInit();
  }

  // Initialize current store name in the text field
  Future<void> initializeStoreName() async {
    updatedStoreName.text = sellerController.seller.value.storeName;
  }

  Future<void> updateStoreName() async {
    try {
      // Show loading
      BunLoader.openLoadingDialog("Wiggling our tails... Updating your store info!");

      // Check network
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      // Form validation
      if (!updateStoreNameFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      // Prepare update data
      Map<String, dynamic> data = {'storeName': updatedStoreName.text.trim()};

      // Update Firestore
      await sellerRepository.updateSingleSellerField(data);

      // Update local Rx value
      sellerController.seller.value.storeName = updatedStoreName.text.trim();

      // Stop loader
      BunLoader.stopLoading();

      // Show success
      BunSnackBar.bunsuccess(
        title: "Store Updated!",
        message: "Your Store Name has been successfully updated.",
      );

      // Navigate back to seller page
      Get.off(() => const SellerMainPage(selectedIndex: 3));
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Oops! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }
}