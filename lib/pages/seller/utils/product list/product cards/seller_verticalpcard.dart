import 'package:bunbunmart/models/product_model.dart';
import 'package:flutter/material.dart';

class SellerVerticalPcard extends StatelessWidget {
  final ProductModel product;
  final Color? color;

  const SellerVerticalPcard({super.key, required this.product, this.color});

  @override
  Widget build(BuildContext context) {
    final firstImageUrl = product.productImages.isNotEmpty ? product.productImages.first : null;

    return GestureDetector(
      onTap: () {
        // Navigate to product details (you can update this to pass product data)
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: 160,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: firstImageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(firstImageUrl),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/products/placeholder.jpg'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),

            const SizedBox(height: 5.0),
            // Product Name & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '₱${product.productPrice.toString()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
