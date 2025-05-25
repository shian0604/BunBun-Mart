import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/textfields/white_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    final controller = AddressController.instance;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: BunSizeConfig.screenWidth,
        height: BunSizeConfig.screenHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BunColors.navy, BunColors.gray, BunColors.beige],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage('assets/screentone/tone.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
            repeat: ImageRepeat.noRepeat,
            opacity: 0.03,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: controller.addressFormKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: WhiteBackButton(
                          onPressed: () => Get.back(),
                        ),
                      ),
                      BunbunHeader(
                        header: "Add Address",
                        color: BunColors.white,
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                  Container(
                    width: BunSizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BunColors.white,
                    ),

                    child: Column(
                      children: [
                        MyInputField(
                          labelText: "Recipient",
                          imagepath: "assets/icons/name.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.recipient,
                          validator: (value) => InputValidator.validateEmptyText("Recipient", value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "Phone Number",
                          imagepath: "assets/icons/phone.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.phoneNumber,
                          validator: (value) => InputValidator.validatePhoneNumber(value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "Street",
                          imagepath: "assets/icons/street.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.street,
                          validator: (value) => InputValidator.validateEmptyText("Street", value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "City",
                          imagepath: "assets/icons/city.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.city,
                          validator: (value) => InputValidator.validateEmptyText("City", value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "State",
                          imagepath: "assets/icons/state.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.state,
                          validator: (value) => InputValidator.validateEmptyText("State", value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "Postal Code",
                          imagepath: "assets/icons/postal_code.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.postalCode,
                          validator: (value) => InputValidator.validateEmptyText("Postal Code", value),
                        ),
                        SizedBox(height: 8),
                        MyInputField(
                          labelText: "Country",
                          imagepath: "assets/icons/country.png",
                          showBorder: true,
                          radius: BorderRadius.circular(20),
                          controller: controller.country,
                          validator: (value) => InputValidator.validateEmptyText("Country", value),
                        ),
                        SizedBox(height: 16),
                        BunButton(
                          onTap: () => controller.addNewAddress(),
                          padding: EdgeInsets.all(16),
                          radius: BorderRadius.circular(20),
                          child: Center(
                            child: BTextBold(
                              text: "Add Address",
                              color: BunColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
