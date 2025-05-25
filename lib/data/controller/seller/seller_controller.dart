import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/seller_model.dart';
import 'package:bunbunmart/pages/seller/features/seller_reauth.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerController extends GetxController {
  static SellerController get instance => Get.find();

  // Variables
  final profileLoading = false.obs;
  Rx<SellerModel> seller = SellerModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final sellerRepository = Get.put(SellerRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchSellerRecord();
  }

  /// Fetch seller data
  Future<void> fetchSellerRecord() async {
    try {
      profileLoading.value = true;
      final sellerData = await sellerRepository.fetchSellerDetails();
      seller(sellerData);
    } catch (e) {
      seller(SellerModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Delete account confirmation popup
  void deleteAccountWarningPopup() async {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(16.0),
      titleStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: BunColors.black,
      ),
      middleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: BunColors.black,
      ),
      title: "Close your Shop? 💼",
      middleText:
          "Are you sure you want to permanently delete your seller account? All store data will be lost forever.",
      confirm: ElevatedButton(
        onPressed: () async => deleteSellerAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: BunColors.richRed,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text("Delete", style: TextStyle(color: Colors.white)),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text("Cancel"),
        ),
      ),
    );
  }

  /// Delete seller account
  Future<void> deleteSellerAccount() async {
    try {
      BunLoader.openLoadingDialog("Processing your request...");

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider == 'google.com') {
        await auth.signInWithGoogle();
        await auth.deleteAccount();
      } else if (provider == 'password') {
        BunLoader.stopLoading();
        Get.to(() => const SellerReauth());
      }
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Oops!",
        message: e.toString(),
      );
    }
  }

  /// Re-authenticate and delete seller
  Future<void> reAuthenticateEmailAndPasswordSeller() async {
    try {
      BunLoader.openLoadingDialog("Reauthenticating...");

      // Validate form
      if (!reAuthFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateEmailAndPasswordUser(
              verifyEmail.text.trim(), verifyPassword.text.trim());

      await AuthenticationRepository.instance.deleteAccount();

      BunLoader.stopLoading();
      BunSnackBar.bunsuccess(
        title: "Store Closed Successfully 💼",
        message:
            "Your seller account has been removed. We hope to see your store again soon!",
      );

      Get.offAll(() => const LoginPage());
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Something went wrong",
        message: e.toString(),
      );
    }
  }
}
