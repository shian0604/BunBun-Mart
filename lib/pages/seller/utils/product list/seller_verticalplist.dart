import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/product%20cards/seller_verticalpcard.dart';
import 'package:flutter/material.dart';

class SellerVerticalPlist extends StatefulWidget {
  final String sellerId;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const SellerVerticalPlist({
    super.key,
    required this.sellerId,
    this.color = const Color(0xFFEFE8D8),
    this.padding,
  });

  @override
  State<SellerVerticalPlist> createState() => _SellerVerticalPlistState();
}

class _SellerVerticalPlistState extends State<SellerVerticalPlist> {
  late Future<List<ProductModel>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ProductRepository.instance.fetchProductsBySellerId(widget.sellerId);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth >= 600) crossAxisCount = 3;
    if (screenWidth >= 900) crossAxisCount = 4;

    return FutureBuilder<List<ProductModel>>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final products = snapshot.data ?? [];

        if (products.isEmpty) {
          return const Center(child: Text("No products found."));
        }

        return Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 6.0, horizontal: 60.0),
          child: GridView.builder(
            itemCount: products.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              mainAxisExtent: 220,
            ),
            itemBuilder: (_, index) => SellerVerticalPcard(
              product: products[index],
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
