import 'package:bunbunmart/data/cloud_helper_functions.dart';
import 'package:bunbunmart/data/controller/user/checkout_controller.dart';
import 'package:bunbunmart/data/repository/authentication_repository.dart';
import 'package:bunbunmart/data/repository/network_manager.dart';
import 'package:bunbunmart/data/repository/user/address_repository.dart';
import 'package:bunbunmart/models/address_model.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/pages/features/address/add_address.dart';
import 'package:bunbunmart/pages/features/address/adress_card.dart';
import 'package:bunbunmart/pages/features/bun_address.dart';
import 'package:bunbunmart/utilities/layout/buttons/bunbutton.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_fullscreen_loader.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  //Variables
  final recipient = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  //fetch all user Address
  Future<List<AddressModel>> allUserAddress() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
      );
      return addresses;
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Oops! Address Not Found 🐾",
        message:
            "We couldn't sniff out that address. Please double-check and try again!",
      );

      return [];
    }
  }

  //Show address ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder:
          (_) => Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BTextBold(
                    text: 'Select Address',
                    color: BunColors.black,
                    size: 16,
                  ),
                  FutureBuilder(
                    future: allUserAddress(),
                    builder: (_, snapshot) {
                      // Helper Function: Handle Loader, No Record, OR ERROR Message
                      final response =
                          CloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                          );
                      if (response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder:
                            (_, index) => AdressCard(
                              address: snapshot.data![index],
                              onPressed:
                                  () => deleteAddressWarningPopup(
                                    snapshot.data![index],
                                  ),
                              onTap: () async {
                                await CheckoutController.instance.selectAddress(
                                  snapshot.data![index],
                                );
                                Get.back();
                              },
                            ),
                      );
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () async {
                        Get.back(); // Close current popup
                        await Get.to(AddAddress());
                      },
                      child: BunButton(text: "Add New Address"),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  //select address
  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      BunLoader.openLoadingDialog(
        "Sniffing out your new default address... 🐶✨",
      );
      //clear the "selected" field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
          selectedAddress.value.id,
          false,
        );
      }

      //assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      await addressRepository.updateSelectedField(
        selectedAddress.value.id,
        true,
      );

      BunLoader.stopLoading();
      BunSnackBar.bunsuccess(
        title: "All Set! 🐾",
        message:
            "Your default address has been updated — ready to deliver your fur-tastic goodies!",
      );

      return newSelectedAddress;
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Uh-oh! Address Selection Error 🐕",
        message:
            "Something went wrong picking your address. Give it another try, please!",
      );
      BunLoader.stopLoading();
      return null;
    }
  }

  Future addNewAddress() async {
    try {
      BunLoader.openLoadingDialog("Snuggling your address safely... 🐾");

      //Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        BunLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!addressFormKey.currentState!.validate()) {
        BunLoader.stopLoading();
        return;
      }

      final userId = AuthenticationRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        BunLoader.stopLoading();
        BunSnackBar.bunerror(
          title: "Oops! ID Not Found 🐕‍🦺",
          message:
              "Please make sure you’re logged in with your email to add a new address.",
        );
      }

      final address = AddressModel(
        id: const Uuid().v4(),
        userId: userId,
        recipient: recipient.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);

      //Update selected address status
      address.id = id;
      selectedAddress(address);

      BunLoader.stopLoading();

      BunSnackBar.bunsuccess(
        title: "Address Saved! 🎉",
        message:
            "Your cozy new address is all set for your next BunBun Mart order!",
      );

      //Refresh address Data
      refreshData.toggle();

      //Reset Fields
      resetFormFields();

      Get.to(() => BunBunAddress());
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Uh-oh! Couldn’t Save Address 🐾",
        message: e.toString(),
      );
    }
  }

  void deleteAddressWarningPopup(AddressModel address) {
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
      title: "🐾 Remove Address?",
      middleText:
          "Are you sure you want to say goodbye to this address for good? 🐶💔",

      confirm: ElevatedButton(
        onPressed: () async {
          Get.back(); // Close the dialog first
          await deleteAddress(address);
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

  Future<void> deleteAddress(AddressModel address) async {
    try {
      BunLoader.openLoadingDialog(
        "Fetching the last sniff... Deleting address... 🐾",
      );

      // Delete the address
      await addressRepository.deleteAddress(address.id);

      // If the deleted address was the selected one, reset it
      if (selectedAddress.value.id == address.id) {
        selectedAddress.value = AddressModel.empty();
      }

      // Refresh the address list
      refreshData.toggle();

      BunLoader.stopLoading();
      BunSnackBar.bunsuccess(
        title: "All Done! 🐕‍🦺",
        message: "Address deleted successfully — no more deliveries there!",
      );
    } catch (e) {
      BunLoader.stopLoading();
      BunSnackBar.bunerror(
        title: "Oops! Delete Failed 🐾",
        message: e.toString(),
      );
    }
  }

  void resetFormFields() {
    recipient.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
