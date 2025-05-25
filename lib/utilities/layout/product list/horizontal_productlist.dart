import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_horizontal.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:get/get.dart';
class HorizontalProductlist extends StatelessWidget {
  const HorizontalProductlist({super.key});
  

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    BunSizeConfig.init(context);

    return Obx(() {
      final cartItems = controller.cartItems;

      if (cartItems.isEmpty) {
        return const Center(child: Text("Your cart is empty."));
      }

      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: 15.0),
        itemCount: cartItems.length,
        itemBuilder: (_, index) {
          final item = cartItems[index];
          return HorizontalPCard(cartItem: item);
        },
      );
    });
  }
}
