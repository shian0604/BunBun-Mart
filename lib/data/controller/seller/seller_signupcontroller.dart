import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/seller/seller_repository.dart';
import 'package:bunbunmart/login/email%20verification/bun_emailverification.dart';
import 'package:bunbunmart/models/seller_model.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerSignupcontroller extends GetxController {
  static SellerSignupcontroller get instance => Get.find();

  // Text controllers
  final fullName = TextEditingController();
  final storeName = TextEditingController();
  final email = TextEditingController();
  final contactNumber = TextEditingController();
  final password = TextEditingController();
  final reenterpassword = TextEditingController();
  final businessType = TextEditingController();
  final pickupAddress = TextEditingController();
  final productCategory = TextEditingController();
  final shippingCourier = TextEditingController();

  // Booleans
  final hidePassword = true.obs;
  final hideReenterPassword = true.obs;
  final returnAndRefundPolicy = false.obs;
  final agreementToTerms = false.obs;
  final agreementToDataPrivacy = false.obs;
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void sellersSignup() async {
    try {
      //start loading
      BunLoader.openLoadingDialog(
        "Hang tight! We're getting your pawsome profile ready...",
      );

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!signupFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      // Return and Refund Policy Check
      if (!returnAndRefundPolicy.value) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Hold up! 🐾",
          message:
              "We want to make sure you’re covered! Please hop through our Return & Refund Policy before joining the BunBun Family.",
        );
        return;
      }

      // Terms and Conditions Check
      if (!agreementToTerms.value) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Just a quick pawse! 🐰",
          message:
              "Before you wag your way in, make sure you’ve sniffed through our Terms & Conditions!",
        );
        return;
      }

      // Data Privacy Check
      if (!agreementToDataPrivacy.value) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Privacy check-in! 🔒",
          message:
              "Your safety matters to us. Take a moment to peek at our Data Privacy Policy before we welcome you to the BunBun Family!",
        );
        return;
      }

      //Register user in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      //Save Authenticated seller data in Firebase firestore
      final newSeller = SellerModel(
        id: userCredential.user!.uid,
        userRole: 'seller',
        fullName: fullName.text.trim(),
        storeName: storeName.text.trim(),
        email: email.text.trim(),
        contactNumber: contactNumber.text.trim(),
        businessType: businessType.text.trim(),
        pickupAddress: pickupAddress.text.trim(),
        productCategory: productCategory.text.trim(),
        shippingCourier: shippingCourier.text.trim(),
        profilePicture: '',
      );

      final sellerRepository = Get.put(SellerRepository());
      await sellerRepository.saveSellerRecord(newSeller);

      //Remove loader
      BunLoader.stopLoading();

      //Show success msg
      BunSnackBar.bunsuccess(
        title: "Paw-some News! 🎉",
        message:
            "You're officially part of the BunBun Family! Just one more hop—verify your email to start the adventure!",
      );

      //Move to verify email screen
      Get.to(() => BunEmailVerification(email: email.text.trim()));
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }

  @override
  void onClose() {
    fullName.dispose();
    storeName.dispose();
    email.dispose();
    contactNumber.dispose();
    password.dispose();
    businessType.dispose();
    pickupAddress.dispose();
    productCategory.dispose();
    shippingCourier.dispose();
    super.onClose();
  }
}
