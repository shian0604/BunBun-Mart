import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/features/bun_productdetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductcardVertical extends StatelessWidget {
  final ProductModel product;
  final Color? color;

  const ProductcardVertical({super.key, required this.product, this.color});

  @override
  Widget build(BuildContext context) {
    final firstImageUrl = product.productImages.isNotEmpty
        ? product.productImages.first
        : 'https://via.placeholder.com/150'; // fallback image

    return GestureDetector(
      onTap: () {
        Get.to(() => BunProductDetails(product: product));
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                firstImageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),

            SizedBox(height: 5.0),

            // Product Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product name and price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontFamily: "Poppins", fontSize: 12, color: Colors.black),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        '₱${product.productPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
