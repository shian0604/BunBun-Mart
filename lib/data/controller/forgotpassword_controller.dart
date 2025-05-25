import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/login/email%20verification/bun_resetemailsent.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotpasswordController extends GetxController {
  static ForgotpasswordController get instance => Get.find();

  //Variable
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  //Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      //start loading
      BunLoader.openLoadingDialog("Wiggling our tails... Logging you in now!");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!forgotPasswordFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      //Send Email to Reset Password
      await AuthenticationRepository.instance.sendEPasswordResetEmail(
        email.text.trim(),
      );

      //Remove Loader
      BunLoader.stopLoading();

      //Show Success Screen
      BunSnackBar.bunsuccess(
        title: "Paw-sword Reset Link Sent! 🐾📧",
        message:
            "If that email’s in our burrow, your reset link is already hopping its way to your inbox!",
      );

      //Redirect
      Get.to(() => BunResetEmailSent(email: email.text.trim()));
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      BunLoader.openLoadingDialog("Wiggling our tails... Logging you in now!");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Send Email to Reset Password
      await AuthenticationRepository.instance.sendEPasswordResetEmail(email);

      //Remove Loader
      BunLoader.stopLoading();

      //Show Success Screen
      BunSnackBar.bunsuccess(
        title: "One More Hop! 🐇📧",
        message:
            "We’ve sent the email again—check your inbox to reset your password!",
      );
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }
}
