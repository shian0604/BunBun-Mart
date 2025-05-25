import 'package:bunbunmart/data/controller/seller/seller_signupcontroller.dart';
import 'package:bunbunmart/data/validator/input_validator.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/textfields/underline_inputfield.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:get/get.dart';

class SellerRegForm extends StatefulWidget {
  const SellerRegForm({super.key});

  @override
  State<SellerRegForm> createState() => _SellerRegFormState();
}

class _SellerRegFormState extends State<SellerRegForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SellerSignupcontroller());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BunColors.white,
            ),
            width: BunSizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),

            child: Column(
              children: [
                BTextBold(
                  text: "Seller Information",
                  color: BunColors.black,
                  size: 16,
                ),
                SizedBox(height: 6.0),
                UnderlineInputfield(
                  labelText: "Full name",
                  controller: controller.fullName,
                  validator: (value) => InputValidator.validateFullName(value),
                ),
                UnderlineInputfield(
                  labelText: "Store name",
                  controller: controller.storeName,
                  validator: (value) => InputValidator.validateStoreName(value),
                ),
                UnderlineInputfield(
                  labelText: "Email Address",
                  controller: controller.email,
                  validator: (value) => InputValidator.validateEmail(value),
                ),
                UnderlineInputfield(
                  labelText: "Contact Number",
                  controller: controller.contactNumber,
                  validator:
                      (value) => InputValidator.validatePhoneNumber(value),
                ),
                Obx(
                  () => UnderlineInputfield(
                    labelText: "Password",
                    controller: controller.password,
                    validator:
                        (value) => InputValidator.validatePassword(value),
                    obscureText: controller.hidePassword.value,
                    suffixpath: 'assets/icons/visible.png',
                    altSuffixPath: 'assets/icons/eye.png',
                    isToggled: controller.hidePassword.value,
                    suffixAction:
                        () =>
                            controller.hidePassword.value =
                                !controller.hidePassword.value,
                  ),
                ),
                Obx(
                  () => UnderlineInputfield(
                    labelText: "Re-enter Password",
                    controller: controller.reenterpassword,
                    validator:
                        (value) => InputValidator.validateReEnterPassword(
                          value,
                          controller.password.text,
                        ),
                    suffixpath: 'assets/icons/visible.png',
                    altSuffixPath: 'assets/icons/eye.png',
                    isToggled: controller.hideReenterPassword.value,
                    suffixAction:
                        () =>
                            controller.hideReenterPassword.value =
                                !controller.hideReenterPassword.value,
                    obscureText: controller.hideReenterPassword.value,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.0),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BunColors.white,
            ),
            width: BunSizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              children: [
                BTextBold(
                  text: "Bussiness & Address Information",
                  color: BunColors.black,
                  size: 16,
                ),
                UnderlineInputfield(
                  labelText: "Bussiness Type",
                  controller: controller.businessType,
                  validator:
                      (value) => InputValidator.validateEmptyText(
                        "Bussiness Type",
                        value,
                      ),
                ),

                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BTextBold(
                    text: "Pickup Address",
                    color: BunColors.black,
                  ),
                ),
                UnderlineInputfield(
                  labelText: "Pickup Address",
                  controller: controller.pickupAddress,
                  validator:
                      (value) => InputValidator.validateEmptyText(
                        "Pickup Address",
                        value,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BunColors.white,
            ),
            width: BunSizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              children: [
                BTextBold(
                  text: "Product & Shipping Details",
                  color: BunColors.black,
                ),
                UnderlineInputfield(
                  labelText: "Product Category",
                  controller: controller.productCategory,
                  validator:
                      (value) => InputValidator.validateProductCategory(value),
                ),
                UnderlineInputfield(
                  labelText: "Shipping Courier",
                  controller: controller.shippingCourier,
                  validator:
                      (value) => InputValidator.validateShippingCourier(value),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BunbunText(
                        text: "Agreement to to Return and Refund Policy",
                        color: Colors.black.withOpacity(0.6),
                        weight: FontWeight.w600,
                      ),
                      Obx(
                        () => BunBoxCheckBox(
                          value: controller.returnAndRefundPolicy.value,
                          onChanged:
                              (value) =>
                                  controller.returnAndRefundPolicy.value =
                                      value!,
                        ),
                      ),
                    ],
                  ),
                ),

                BunDivider(
                  color: BunColors.black.withOpacity(0.3),
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: BunColors.white,
            ),
            width: BunSizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              children: [
                BTextBold(
                  text: "Product & Shipping Details",
                  color: BunColors.black,
                ),
                SizedBox(height: 8.0),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BunbunText(
                        text: "Agreement to Terms and Conditions",
                        color: Colors.black.withOpacity(0.6),
                        weight: FontWeight.w600,
                      ),
                      Obx(
                        () => BunBoxCheckBox(
                          value: controller.agreementToTerms.value,
                          onChanged:
                              (value) =>
                                  controller.agreementToTerms.value = value!,
                        ),
                      ),
                    ],
                  ),
                ),

                BunDivider(
                  color: BunColors.black.withOpacity(0.3),
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BunbunText(
                        text: "Agreement to to Data Privacy",
                        color: Colors.black.withOpacity(0.6),
                        weight: FontWeight.w600,
                      ),
                      Obx(
                        () => BunBoxCheckBox(
                          value: controller.agreementToDataPrivacy.value,
                          onChanged:
                              (value) =>
                                  controller.agreementToDataPrivacy.value =
                                      value!,
                        ),
                      ),
                    ],
                  ),
                ),

                BunDivider(
                  color: BunColors.black.withOpacity(0.3),
                  indent: 10,
                  endIndent: 10,
                  thickness: 1.5,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          BunButton(
            onTap: () => controller.sellersSignup(),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: BTextBold(text: "Register", color: BunColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
