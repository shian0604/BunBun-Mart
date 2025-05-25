import 'package:bunbunmart/data/controller/user/cart_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/cart_model.dart';
import 'package:bunbunmart/models/order_model.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalPCard extends StatelessWidget {
  final CartModel cartItem;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;

  const HorizontalPCard({
    super.key,
    required this.cartItem,
    this.padding,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.find<CartController>();
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 90,
        width: BunSizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border:
              border ??
              Border.all(color: Colors.black.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left section
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Transform.scale(
                      scale: 0.8,
                      child: BunCircleCBox(
                        tristate: true,
                        value: CartController.instance.isSelected(
                          cartItem.cartItemId,
                        ),
                        onChanged: (_) {
                          CartController.instance.toggleCartItemSelection(
                            cartItem.cartItemId,
                          );
                        },
                      ),
                    ),
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      cartItem.productImage,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BunbunText(
                          text: cartItem.productName,
                          color: Colors.black,
                        ),
                        BTextBold(
                          text: "₱${cartItem.totalPrice.toStringAsFixed(2)}",
                          color: Colors.black,
                        ),
                        BTextSmall(
                          text:
                              "Size: ${cartItem.selectedSize}, Color: ${cartItem.selectedColor}",
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Quantity controls
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: Row(
                children: [
                  CircularIcons(
                    onPressed: () => controller.decrementQuantity(cartItem),
                    imagepath: "assets/icons/minus.png",
                    imageheight: 12,
                    imagewidth: 12,
                    color: Colors.grey.withOpacity(0.2),
                    height: 36,
                    width: 36,
                  ),
                  const SizedBox(width: 8.0),
                  BunbunSubText(
                    subtext: cartItem.quantity.toString(),
                    color: BunColors.black,
                  ),
                  const SizedBox(width: 8.0),
                  CircularIcons(
                    onPressed: () => controller.incrementQuantity(cartItem),
                    imagepath: "assets/icons/plus.png",
                    imageheight: 12,
                    imagewidth: 12,
                    color: BunColors.navy,
                    height: 36,
                    width: 36,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BunPCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final CartModel item;

  const BunPCard({super.key, required this.item, this.padding, this.border});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        height: 90,
        width: BunSizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border:
              border ??
              Border.all(color: Colors.black.withOpacity(0.5), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product image and details
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    item.productImage,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 20),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BunbunText(text: item.productName, color: Colors.black),
                        BTextBold(
                          text: "₱${item.totalPrice.toStringAsFixed(2)}",
                          color: Colors.black,
                        ),
                        BTextSmall(
                          text:
                              "Qty: ${item.quantity} | Size: ${item.selectedSize} | Color: ${item.selectedColor}",
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HPCard extends StatefulWidget {
  final OrderModel order; // Receive order data
  final VoidCallback onPressed;

  const HPCard({super.key, required this.order, required this.onPressed});

  @override
  State<HPCard> createState() => _HPCardState();
}

class _HPCardState extends State<HPCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 90,
        width: BunSizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: BunColors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: BunColors.black.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product image
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.order.items.first.productImage,
                      height: 80,
                      width: 80,
                    ),
                  ),

                  SizedBox(width: 20),

                  // Order details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BunbunText(
                          text: widget.order.mergedProductNames, // Product name
                          color: Colors.black,
                        ),
                        BTextBold(
                          text:
                              "₱${widget.order.totalAmount.toStringAsFixed(2)}",
                          color: Colors.black,
                        ),
                        BTextSmall(
                          text:
                              "Status: ${widget.order.orderStatus}", // Order status
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  // Show delete button only if the order is NOT "Completed"
                  if (widget.order.orderStatus.toLowerCase() != "completed")
                    CircularIcons(
                      onPressed: widget.onPressed,
                      imagepath: "assets/seller/remove.png",
                      imageheight: 16,
                      imagewidth: 16,
                      padding: EdgeInsets.only(left: 24),
                      color: BunColors.richRed,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
