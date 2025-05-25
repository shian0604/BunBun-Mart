import 'package:bunbunmart/data/controller/user/order_controller.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/order_model.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/utils/bun_dropdown.dart';
import 'package:bunbunmart/pages/seller/utils/seller%20products/products_stockeditor.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class SellerHorizontalPcard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productCategory;
  final String? imageUrl;
  final int quantity;
  final bool isSelected;
  final Function(bool?) onSelected;

  final String sellerId;
  final String productId;

  const SellerHorizontalPcard({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    this.imageUrl,
    required this.quantity,
    required this.isSelected,
    required this.onSelected,
    required this.sellerId,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
          ),
          child: Row(
            children: [
              Transform.scale(
                scale: 0.8,
                child: BunCircleCBox(onChanged: onSelected, value: isSelected),
              ),

              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image:
                        imageUrl != null
                            ? DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.cover,
                            )
                            : const DecorationImage(
                              image: AssetImage(
                                'assets/products/placeholder.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
              ),

              SizedBox(width: 20),

              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BunbunText(text: productName, color: Colors.black),
                    BTextBold(
                      text: '₱${productPrice.toString()}',
                      color: Colors.black,
                      maxLiness: 1,
                    ),
                    BTextSmall(
                      text: productCategory,
                      color: Colors.black,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              ProductsStockeditor(
                sellerId: sellerId,
                productId: productId,
                initialQuantity: quantity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SellerOrderCard extends StatefulWidget {
  final OrderModel order; // Receive order data
  final VoidCallback onPressed;

  const SellerOrderCard({
    super.key,
    required this.order,
    required this.onPressed,
  });

  @override
  State<SellerOrderCard> createState() => _SellerOrderCardState();
}

class _SellerOrderCardState extends State<SellerOrderCard> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                              "Order Date: ${widget.order.orderDate}", // Order status
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 150,
                      ), // Ensure bounded width
                      child: BunDropdown(
                        initialValue: widget.order.orderStatus,
                        items: ["Unpaid", "Pending", "Shipped", "Completed"],
                        onChanged: (selectedStatus) {
                          OrderController.instance.updateOrderStatus(
                            widget.order.orderId,
                            selectedStatus,
                          );
                        },
                      ),
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
