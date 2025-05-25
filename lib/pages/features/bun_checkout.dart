// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

import 'package:bunbunmart/data/controller/user/address_controller.dart';
import 'package:bunbunmart/data/controller/user/checkout_controller.dart';
import 'package:bunbunmart/data/controller/user/order_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/bun%20checkout/checkout_checkboxicons.dart';
import 'package:bunbunmart/utilities/bun%20checkout/checkout_textbetween.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunBunCheckOut extends StatefulWidget {
  const BunBunCheckOut({super.key});

  @override
  State<BunBunCheckOut> createState() => _BunBunCheckOutState();
}

class _BunBunCheckOutState extends State<BunBunCheckOut> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    final CheckoutController checkoutController = Get.put(CheckoutController());
    final OrderController orderController = Get.put(OrderController());
    final addressController = Get.find<AddressController>();
    return Scaffold(
      backgroundColor: BunColors.lightbeige,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                BunCustomHeader(
                  height: 120,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: WhiteBackButton(
                          onPressed: () {
                            Get.off(() => MainPage(selectedIndex: 1));
                          },
                        ),
                      ),
                      Center(
                        child: BunbunHeader(
                          header: "Check out",
                          color: BunColors.lightbeige,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(30.0),
                  width: BunSizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: BunColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Address section
                      Obx(() {
                        final selected =
                            addressController.selectedAddress.value;

                        // Show selected address
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    BunBunImage(
                                      imageheight: 16,
                                      imagewidth: 16,
                                      imagepath: "assets/icons/location.png",
                                    ),
                                    SizedBox(width: 5.0),
                                    BTextBold(
                                      text: selected.recipient,
                                      size: 16,
                                      color: BunColors.black,
                                    ),
                                  ],
                                ),
                                BTextSmall(
                                  text: selected.phoneNumber,
                                  color: BunColors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: BunDetailsText(
                                      text:
                                          selected
                                              .toString(), // Replace with actual field like selected.fullAddress
                                      color: BunColors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  BunProceedButton(
                                    onPressed: () {
                                      addressController.selectNewAddressPopup(
                                        context,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),

                      BunDivider(
                        color: BunColors.black,
                        indent: 0,
                        endIndent: 0,
                      ),

                      SizedBox(height: 10.0),
                      //Shipping Method
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BTextBold(
                          text: "Shipping Method",
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Transform.scale(
                                scale: 0.8,
                                child: BunCircleCBox(
                                  tristate: true,
                                  value:
                                      checkoutController
                                          .isStandardShippingSelected
                                          .value,
                                  onChanged: (value) {
                                    checkoutController
                                        .isStandardShippingSelected
                                        .value = value ?? false;
                                  },
                                ),
                              ),
                            ),

                            SizedBox(width: 10.0),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      BTextBold(
                                        text: "STANDARD SHIPPING",
                                        color: BunColors.black,
                                      ),
                                      SizedBox(width: 5.0),
                                      BunbunText(
                                        text: "Free Shipping",
                                        color: BunColors.navy,
                                      ),
                                    ],
                                  ),

                                  BunbunText(
                                    text: checkoutController.estimatedArrival,
                                    color: BunColors.black.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      BunDivider(
                        color: BunColors.black,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(height: 10.0),

                      //Payment Method
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BTextBold(
                          text: "Payment Method",
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Obx(
                          () => Column(
                            children: [
                              CheckoutRadioIcon(
                                imagepath: "assets/icons/checkout/money.png",
                                text: "Cash on Delivery",
                                groupValue:
                                    checkoutController
                                        .selectedPaymentMethod
                                        .value,
                                value: "Cash on Delivery",
                                onChanged:
                                    (val) =>
                                        checkoutController
                                            .selectedPaymentMethod
                                            .value = val!,
                              ),
                              CheckoutRadioIcon(
                                imagepath:
                                    "assets/icons/checkout/gcash-seeklogo.png",
                                text: "GCash",
                                groupValue:
                                    checkoutController
                                        .selectedPaymentMethod
                                        .value,
                                value: "GCash",
                                onChanged:
                                    (val) =>
                                        checkoutController
                                            .selectedPaymentMethod
                                            .value = val!,
                              ),
                              CheckoutRadioIcon(
                                imagepath: "assets/icons/checkout/atm-card.png",
                                text: "Credit/Debit Card",
                                groupValue:
                                    checkoutController
                                        .selectedPaymentMethod
                                        .value,
                                value: "Credit/Debit Card",
                                onChanged:
                                    (val) =>
                                        checkoutController
                                            .selectedPaymentMethod
                                            .value = val!,
                              ),
                              CheckoutRadioIcon(
                                imagepath: "assets/icons/checkout/paypal.png",
                                text: "Paypal",
                                groupValue:
                                    checkoutController
                                        .selectedPaymentMethod
                                        .value,
                                value: "Paypal",
                                onChanged:
                                    (val) =>
                                        checkoutController
                                            .selectedPaymentMethod
                                            .value = val!,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                Container(
                  padding: EdgeInsets.all(30.0),
                  width: BunSizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    color: BunColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Obx(() {
                        final items = checkoutController.selectedCartItems;
                        if (items.isEmpty) {
                          return Center(child: Text("No items selected."));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (_, index) {
                            final item = items[index];
                            return BunPCard(
                              item: item,
                              padding: EdgeInsets.symmetric(vertical: 6),
                            );
                          },
                        );
                      }),

                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BTextBold(
                          text: "Order Summary",
                          size: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Obx(() {
                          return CheckoutTextBetween(
                            text1:
                                "Subtotal (${checkoutController.totalQuantity} item${checkoutController.totalQuantity > 1 ? 's' : ''}):",
                            text2:
                                "₱${checkoutController.totalOrderPrice.toStringAsFixed(2)}",
                          );
                        }),
                      ),
                      SizedBox(height: 5.0),
                      BunDivider(
                        color: BunColors.black,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            CheckoutTextBetween(
                              text1: "Shipping fee:",
                              text2: "FREE",
                            ),
                            SizedBox(height: 5.0),

                            CheckoutTextBetween(
                              text1: "Shipping guarantee:",
                              text2: "FREE",
                            ),
                            SizedBox(height: 5.0),
                            CheckoutTextBetween(
                              text1: "COD fee:",
                              text2: "FREE",
                            ),
                            SizedBox(height: 5.0),
                            Obx(() {
                              return CheckoutTextBetween(
                                text1: "Order total:",
                                text2:
                                    "₱${checkoutController.totalOrderPrice.toStringAsFixed(2)}",
                                weight: FontWeight.w600,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16.0),

                BunButton(
                  padding: EdgeInsets.all(25.0),
                  width: BunSizeConfig.screenWidth,
                  onTap: () async {
                    if (!checkoutController.validateShippingMethod()) {
                      BunSnackBar.bunerror(
                        title: "Error",
                        message: "Please select a shipping method.",
                      );
                      return;
                    }

                    if (!checkoutController.validatePaymentMethod()) {
                      BunSnackBar.bunerror(
                        title: "Error",
                        message: "Please select at least one payment method.",
                      );
                      return;
                    }

                    await orderController.placeOrder();
                  },
                  child: Center(
                    child: BTextBold(
                      text: "Proceed to Order",
                      color: BunColors.lightbeige,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
