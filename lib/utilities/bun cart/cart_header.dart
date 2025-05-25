import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/pages/features/bun_wishlist.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CartHeader extends StatefulWidget {
  const CartHeader({super.key});

  @override
  State<CartHeader> createState() => _CartHeaderState();
}

class _CartHeaderState extends State<CartHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(
                () => BunCircleCBox(
                  tristate: true,
                  value:
                      CartController.instance.selectedCartItems.length ==
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
              BunbunSubText(subtext: "Select All", color: Colors.black),
            ],
          ),

          Wrap(
            children: [
              CircularIcons(
                imagepath: "assets/icons/heart.png",
                imageheight: 20,
                imagewidth: 20,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BunWishlist()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
