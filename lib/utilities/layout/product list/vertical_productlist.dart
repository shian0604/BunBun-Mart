import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_vertical.dart';

class VerticalProductlist extends StatefulWidget {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  const VerticalProductlist({
    super.key,
    this.color = const Color(0xFFEFE8D8),
    this.padding,
  });

  @override
  State<VerticalProductlist> createState() => _VerticalProductlistState();
}

class _VerticalProductlistState extends State<VerticalProductlist> {
  List<ProductModel> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final allSellersSnapshot =
          await FirebaseFirestore.instance.collection('Sellers').get();

      List<ProductModel> loadedProducts = [];

      for (var sellerDoc in allSellersSnapshot.docs) {
        final sellerId = sellerDoc.id;
        final sellerProducts = await ProductRepository.instance
            .fetchProductsBySellerId(sellerId);
        loadedProducts.addAll(sellerProducts);
      }

      if (mounted) {
        setState(() {
          _products = loadedProducts;
          _isLoading = false;
        });
      }
    } catch (e) {
      BunSnackBar.bunerror(
        title: "Yikes! Something went wrong 🐾",
        message: e.toString(),
      );
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount =
        screenWidth >= 900
            ? 4
            : screenWidth >= 600
            ? 3
            : 2;

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding:
              widget.padding ??
              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 60.0),
          child: GridView.builder(
            itemCount: _products.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              mainAxisExtent: 220,
            ),
            itemBuilder:
                (_, index) => ProductcardVertical(
                  product: _products[index],
                  color: widget.color,
                ),
          ),
        );
  }
}
