import 'package:bunbunmart/data/controller/user/user_searchcontroller.dart';
import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/utilities/popups/bun_loaders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/product%20cards/productcard_vertical.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SearchProductlist extends StatefulWidget {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final String? searchKeyword;

  const SearchProductlist({
    super.key,
    this.searchKeyword,
    this.color = const Color(0xFFEFE8D8),
    this.padding,
  });

  @override
  State<SearchProductlist> createState() => _SearchProductlistState();
}

class _SearchProductlistState extends State<SearchProductlist> {
  List<ProductModel> _products = [];
  bool _isLoading = true;
  String _lastKeyword = '';

  @override
  void initState() {
    super.initState();
    _loadProducts(widget.searchKeyword ?? '');
  }

  Future<void> _loadProducts(String keyword) async {
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

      final filteredProducts =
          keyword.isEmpty
              ? loadedProducts
              : loadedProducts.where((product) {
                final name = product.productName.toLowerCase();
                return _isFuzzyMatch(name, keyword.toLowerCase());
              }).toList();

      if (mounted) {
        setState(() {
          _products = filteredProducts;
          _isLoading = false;
          _lastKeyword = keyword;
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

  /// Simple fuzzy matching logic
  bool _isFuzzyMatch(String text, String pattern) {
    return text.contains(pattern) || _levenshtein(text, pattern) <= 2;
  }

  /// Levenshtein Distance
  int _levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<List<int>> matrix = List.generate(
      s.length + 1,
      (_) => List.filled(t.length + 1, 0),
    );

    for (int i = 0; i <= s.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= t.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= s.length; i++) {
      for (int j = 1; j <= t.length; j++) {
        int cost = s[i - 1] == t[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[s.length][t.length];
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

    return GetBuilder<UserSearchController>(
      builder: (controller) {
        final keyword = controller.searchKeyword.value;

        if (_lastKeyword != keyword) {
          _isLoading = true;
          _loadProducts(keyword);
        }

        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_products.isEmpty) {
          return Center(
            child: Text(
              'No products found for "${keyword.isEmpty ? "all" : keyword}"',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, fontFamily: "Poppins", color: BunColors.black),
            ),
          );
        }

        return _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
              padding:
                  widget.padding ??
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 60.0),
              child: GridView.builder(
                itemCount: _products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
      },
    );
  }
}
