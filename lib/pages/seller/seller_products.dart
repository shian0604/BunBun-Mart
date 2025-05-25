import 'package:bunbunmart/data/controller/seller/product_controller.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/features/edit_product.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/seller_horizontalplist.dart';
import 'package:bunbunmart/pages/seller/utils/seller%20products/products_navbar.dart';
import 'package:bunbunmart/pages/seller/utils/seller%20products/products_topnav.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerProducts extends StatefulWidget {

  const SellerProducts({super.key});

  @override
  State<SellerProducts> createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  String sellerId = FirebaseAuth.instance.currentUser!.uid;
  final ValueNotifier<bool> selectAllNotifier = ValueNotifier<bool>(false);
  final GlobalKey<SellerHorizontalPlistState> _plistKey = GlobalKey();

  void _showDeleteConfirmationDialog() async {
    final selectedIds = _plistKey.currentState?.selectedProductIds;

    //Check connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      BunSnackBar.bunerror(
        title: "No Internet! 🌐",
        message:
            "Looks like we lost our carrot connection. Please check your network and try again!",
      );
      return;
    }

    if (selectedIds == null || selectedIds.isEmpty) {
      BunSnackBar.bunerror(
        title: "Oopsie! 🐾",
        message:
            "No products were selected for deletion. Tap-tap and pick the ones to hop away!",
      );
      return;
    }

    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16.0),
      titleStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: BunColors.black,
      ),
      middleTextStyle: const TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: BunColors.black,
      ),

      title: "Delete Products? 🗑️",
      middleText:
          "You're about to send these little items on a forever nap! Their images and details will vanish. Are you sure you wanna do this?",

      confirm: ElevatedButton(
        onPressed: () async {
          Navigator.of(Get.overlayContext!).pop(); // Close dialog
          await _handleDelete(); // Proceed to delete
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: BunColors.richRed,
          side: const BorderSide(color: BunColors.richRed),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: BTextBold(text: "Delete", color: BunColors.white),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: BTextBold(text: "Cancel", color: BunColors.black),
        ),
      ),
    );
  }

  Future<void> _handleDelete() async {
    final selectedIds = _plistKey.currentState?.selectedProductIds;
    BunLoader.openLoadingDialog(
      "Sending your products to the BunBun void... 🗑️",
    );

    //Check connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      BunLoader.stopLoading();
      return;
    }

    if (selectedIds == null || selectedIds.isEmpty) {
      if (!mounted) return;
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Oopsie! 🐾",
        message:
            "No products were selected for deletion. Tap-tap and pick the ones to hop away!",
      );
      return;
    }

    await ProductRepository.instance.deleteSelectedProducts(
      sellerId,
      selectedIds,
    );

    BunLoader.stopLoading();
    BunSnackBar.bunsuccess(
      title: "Poof! 🧼",
      message: "Selected products have been whisked away successfully!",
    );
    if (mounted) {
      setState(() {}); // Refresh UI
    }
  }

  void _handleEdit() async {
    final selectedProductIds = _plistKey.currentState?.selectedProductIds;

    BunLoader.openLoadingDialog("Fetching your bun-derful product for a touch-up... 🐾");

    //Check connection
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "No Internet! 🌐",
        message:
            "Looks like we lost our carrot connection. Please check your network and try again!",
      );
      return;
    }

    if (selectedProductIds == null || selectedProductIds.isEmpty) {
      if (!mounted) return;
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Oopsie! 🐾",
        message:
            "No product was picked for editing. Give one a gentle tap first!",
      );
      return;
    }

    if (selectedProductIds.length != 1) {
      if (!mounted) return;
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Hold up! 🐇",
        message:
            "You can only edit one fluffy item at a time. Please pick just one!",
      );
      return;
    }
    try {
      final ProductModel? product = await ProductRepository.instance
          .getSelectedProductForEdit(selectedProductIds, sellerId);

      if (!mounted) return;

      if (product != null) {
        BunLoader.stopLoading();
        Get.put(ProductController());
        Get.to(() => EditProduct(product: product));
      } else {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Uh-oh! ❌",
          message: "Couldn't find that product. Maybe it hopped away?",
        );
      }
    } catch (e) {
      if (!mounted) return;
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Yikes! 💥",
        message: "Something went wrong while fetching your product: $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BunBunContainer(
                  child: Center(
                    child: BunbunHeader(
                      header: "Manage Products",
                      color: BunColors.lightbeige,
                    ),
                  ),
                ),
              ),
              ProductsTopnav(selectAllNotifier: selectAllNotifier,),
              BunDivider(color: BunColors.black, indent: 30, endIndent: 30),
              SellerHorizontalPlist(key: _plistKey, sellerId: sellerId, selectAllNotifier: selectAllNotifier,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProductsNavbar(
        selectAllNotifier: selectAllNotifier,
        onDeletePressed: _showDeleteConfirmationDialog,
        onEditPressed: _handleEdit,
      ),
    );
  }
}
