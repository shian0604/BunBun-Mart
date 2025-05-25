import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/data/controller/user/checkout_controller.dart';
import 'package:bunbunmart/pages/features/bun_checkout.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/layout/bun_button.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:get/get.dart';

class CartBottomnavbar extends StatefulWidget {
  const CartBottomnavbar({super.key});

  @override
  State<CartBottomnavbar> createState() => _CartBottomnavbarState();
}

class _CartBottomnavbarState extends State<CartBottomnavbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        width: BunSizeConfig.screenWidth,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),

        child: Transform.translate(
          offset: Offset(0, 10),
          child: Column(
            children: [
              BunDivider(color: Colors.black, endIndent: 15, indent: 15),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Obx(
                          () => BunCircleCBox(
                            tristate: true,
                            value:
                                CartController
                                    .instance
                                    .selectedCartItems
                                    .length ==
                                CartController.instance.cartItems.length,
                            onChanged: (checked) {
                              if (checked == true) {
                                CartController.instance.selectAllCartItems();
                              } else {
                                CartController.instance.deselectAllCartItems();
                              }
                            },
                          ),
                        ),
                        BTextBold(text: "Select All", color: Colors.black),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            BTextBold(text: "Total: ", color: Colors.black),
                            BTextBold(
                              text:
                                  "₱${CartController.instance.totalSelectedPrice.toStringAsFixed(2)}",
                              color: Color(0xFF183B49),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 15.0),
                      BunButton(
                        onTap: () {
                          final checkoutController =
                              CheckoutController.instance;
                          if (!checkoutController.validateSelectedItems()) {
                            BunSnackBar.bunerror(
                              title: "No Items Selected",
                              message:
                                  "Please select items to proceed to checkout.",
                            );
                            return;
                          }
                          Get.to(() => BunBunCheckOut());
                        },
                        height: 43,
                        width: 150,
                        child: Center(
                          child: BTextBold(
                            text: "Check out",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
