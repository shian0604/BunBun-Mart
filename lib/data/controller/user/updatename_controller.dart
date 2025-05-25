import 'package:bunbunmart/data/controller/user/user_controller.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/user/user_repository.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController{
  static UpdateNameController get instance => Get.find();

  final updateduserName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  //init user data wen home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //Fetch user Record
  Future<void> initializeNames() async {
    updateduserName.text = userController.user.value.userName;
  }

  Future<void> updateUserName() async {
    try{
      //start Loading
      BunLoader.openLoadingDialog("Wiggling our tails... Logging you in now!");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      //Update user's first & last name in the Firebase Firestore
      Map<String, dynamic> name = {'userName': updateduserName.text.trim()};
      await userRepository.updateSingleField(name);

      //Update the Rx User Value
      userController.user.value.userName = updateduserName.text.trim();

      //Remove Loader
      BunLoader.stopLoading();

      //Show success message
      BunSnackBar.bunsuccess(title: "Information Updated!", message: "Your Username had been Updated");

      //Move to previous Screen
      Get.off(() => const MainPage(selectedIndex: 3,));
    } catch (e) {
      BunLoader.stopLoading();

      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
    }
  }
}