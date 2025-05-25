import 'package:bunbunmart/data/controller/user/user_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //Email and Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      BunLoader.openLoadingDialog("Wiggling our tails... Logging you in now!");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!loginFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      //Save data if Remember me is Selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //Login User using Emal & Password Authentication
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      //Remove Loader
      BunLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }

  //Google SignIn Authentication
  Future<void> googleSignIn() async {
    try{
      //start loading
      BunLoader.openLoadingDialog("Wiggling our tails... Logging you in now!");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Save User Record
      await userController.saveUserRecord(userCredentials);

      //Remove Loader
      BunLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();

    }catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }
}
