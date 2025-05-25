import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/user/user_repository.dart';
import 'package:bunbunmart/login/login.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/user_model.dart';
import 'package:bunbunmart/pages/features/bun_reauthenticateuser.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  //Variables
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //Save user Record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        //map data
        final user = UserModel(
          id: userCredentials.user!.uid,
          userName: userCredentials.user!.displayName ?? '',
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
          userRole: 'buyer',
        );

        //save user data
        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunwarning(
        title: "Uh-oh! 🐾 Data not saved",
        message:
            "Looks like something went a little wonky while saving your info. No worries—you can paw-sitively re-save it in your Profile anytime!",
      );
    }
  }

  //Delete Account Warning
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
      title: "Farewell, BunBuddy? 💔",
      middleText:
          "Are you absolutely sure you want to delete your account forever? This action cannot be undone — all your data will vanish into thin air, never to be retrieved.",

      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
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

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: BTextBold(text: "Cancel", color: BunColors.black),
        ),
      ),
    );
  }

  void deleteUserAccount() async {
    try {
      BunLoader.openLoadingDialog("Wiggling our tails...");

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
        } else if (provider == 'password') {
          BunLoader.stopLoading();
          Get.to(() => const BunReauthenticateUser());
        }
      }
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      BunLoader.openLoadingDialog("Wiggling our tails...");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateEmailAndPasswordUser(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();

      BunLoader.stopLoading();

      BunSnackBar.bunsuccess(
        title: "Account Deleted",
        message:
            "This isn’t goodbye forever... The BunBun Family will always live in your heart. Every smile, every moment — forever part of your story. 🐾💛",
      );

      Get.offAll(() => const LoginPage());
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }
}
