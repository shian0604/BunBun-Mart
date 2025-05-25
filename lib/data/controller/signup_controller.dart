import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/user/user_repository.dart';
import 'package:bunbunmart/login/email%20verification/bun_emailverification.dart';
import 'package:bunbunmart/models/user_model.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final hideReenterPassword = true.obs;
  final privacyPolicy = true.obs;
  final username = TextEditingController();
  final email = TextEditingController();
  final number = TextEditingController();
  final password = TextEditingController();
  final reenterpassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void signup() async {
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

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        BunLoader.stopLoading();
        BunSnackBar.bunwarning(
          title: "Oops! One more thing...",
          message:
              "Before you join the BunBun Family, please give our Terms & Conditions a quick sniff!",
        );
        return;
      }

      //Register user in firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      //Save Authenticated user data in Firebase firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        userName: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: number.text.trim(),
        profilePicture: '',
        userRole: 'buyer',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

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
    username.dispose();
    email.dispose();
    number.dispose();
    password.dispose();
    reenterpassword.dispose();
    super.onClose();
  }
}
