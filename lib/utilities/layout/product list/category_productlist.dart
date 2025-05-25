import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_vertical.dart';

class CategoryProductlist extends StatefulWidget {
  final String? categoryName;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CategoryProductlist({
    Key? key,
    required this.categoryName,
    this.color,
    this.padding,
  }) : super(key: key);

  @override
  State<CategoryProductlist> createState() => _CategoryProductlistState();
}

class _CategoryProductlistState extends State<CategoryProductlist> {
  List<ProductModel> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
  print('Loading products for category: ${widget.categoryName}');
  try {
    final allSellersSnapshot =
        await FirebaseFirestore.instance.collection('Sellers').get();

    List<ProductModel> loadedProducts = [];

    for (var sellerDoc in allSellersSnapshot.docs) {
      final sellerId = sellerDoc.id;
      final sellerProducts =
          await ProductRepository.instance.fetchProductsBySellerId(sellerId);

      final category = widget.categoryName?.toLowerCase().trim();

      // If category is null, empty, or 'all products', load all
      if (category == null || category.isEmpty || category == 'all products') {
        loadedProducts.addAll(sellerProducts);
      } else {
        // Filter by specific category
        final categoryProducts = sellerProducts
            .where((product) =>
                product.productCategory.toLowerCase() == category)
            .toList();
        loadedProducts.addAll(categoryProducts);
      }
    }

    // Shuffle if no category is provided or 'all products' is selected
    final category = widget.categoryName?.toLowerCase().trim();
    if (category == null || category.isEmpty || category == 'all products') {
      loadedProducts.shuffle();
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
  void didUpdateWidget(covariant CategoryProductlist oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryName != widget.categoryName) {
      _loadProducts(); // reload if category changed
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

    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_products.isEmpty) {
      return Center(
        child: BTextBold(text: 'No Products Available', color: BunColors.black)
      );
    }

    return Padding(
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
