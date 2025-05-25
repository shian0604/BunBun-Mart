import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';

class ProductsStockeditor extends StatefulWidget {
  final String sellerId;
  final String productId;
  final int initialQuantity;
  const ProductsStockeditor({
    super.key,
    required this.sellerId,
    required this.productId,
    required this.initialQuantity,
  });

  @override
  State<ProductsStockeditor> createState() => _ProductsStockeditorState();
}

class _ProductsStockeditorState extends State<ProductsStockeditor> {
  late int quantity;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
    quantityController = TextEditingController(text: quantity.toString());
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  // 🔽 Function to increment stock
  void incrementStock() {
    setState(() {
      quantity++;
      quantityController.text = quantity.toString();
    });
    ProductRepository.instance.updateProductStock(widget.sellerId, widget.productId, quantity);
  }

  // 🔽 Function to decrement stock
  void decrementStock() {
    if (quantity > 0) {
      setState(() {
        quantity--;
        quantityController.text = quantity.toString();
      });
      ProductRepository.instance.updateProductStock(widget.sellerId, widget.productId, quantity);
    }
  }

  // 🔽 Function to handle input change
  void onStockInputChanged(String value) {
    final newQuantity = int.tryParse(value);
    if (newQuantity != null && newQuantity >= 0) {
      setState(() {
        quantity = newQuantity;
      });
      ProductRepository.instance.updateProductStock(widget.sellerId, widget.productId, quantity);
      print ("$quantity");
    } else {
      quantityController.text = quantity.toString(); // Reset invalid input
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children: [
          CircularIcons(
            onPressed: decrementStock,
            imagepath: "assets/icons/minus.png",
            imageheight: 12,
            imagewidth: 12,
            color: Colors.grey.withOpacity(0.2),
            height: 36,
            width: 36,
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 40,
            height: 36,
            child: TextField(
              controller: quantityController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: onStockInputChanged,
              style: const TextStyle(
                color: BunColors.black,
                fontFamily: "Poppins",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          CircularIcons(
            onPressed: incrementStock,
            imagepath: "assets/icons/plus.png",
            imageheight: 12,
            imagewidth: 12,
            color: BunColors.navy,
            height: 36,
            width: 36,
          ),
        ],
      ),
    );
  }
}
