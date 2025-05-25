import 'package:bunbunmart/data/repository/seller/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/models/product_model.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/product%20cards/seller_horizontalpcard.dart';
import 'package:bunbunmart/models/size_configs.dart';

class SellerHorizontalPlist extends StatefulWidget {
  final String sellerId;
   final ValueNotifier<bool> selectAllNotifier;

  const SellerHorizontalPlist({super.key, required this.sellerId, required this.selectAllNotifier});

  @override
  State<SellerHorizontalPlist> createState() => SellerHorizontalPlistState();
}

class SellerHorizontalPlistState extends State<SellerHorizontalPlist> {
  late Future<List<ProductModel>> _futureProducts;
  List<ProductModel> _products = [];
  final Set<String> _selectedProductIds = {};

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductRepository.instance.fetchProductsBySellerId(
      widget.sellerId,
    );
    _futureProducts.then((products) {
      setState(() {
        _products = products;
      });
    });

    widget.selectAllNotifier.addListener(() {
      setState(() {
        if (widget.selectAllNotifier.value) {
          _selectedProductIds.addAll(_products.map((p) => p.productId));
        } else {
          _selectedProductIds.clear();
        }
      });
    });
  }
  

  void _onProductSelected(bool? selected, String productId) {
    setState(() {
      if (selected == true && productId.isNotEmpty) {
        _selectedProductIds.add(productId);
      } else {
        _selectedProductIds.remove(productId);
      }
    });
  }

  
  List<String> get selectedProductIds => _selectedProductIds.toList();

  List<ProductModel> get selectedProducts =>
      _products
          .where((product) => _selectedProductIds.contains(product.productId))
          .toList();

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return FutureBuilder<List<ProductModel>>(
      future: _futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products available."));
        }

        _products = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 15.0),
          itemCount: _products.length,
          itemBuilder: (_, index) {
            final product = _products[index];
            final firstImage =
                product.productImages.isNotEmpty
                    ? product.productImages.first
                    : null;

            return SellerHorizontalPcard(
              productId: product.productId,
              sellerId: widget.sellerId,
              productName: product.productName,
              productPrice: product.productPrice.toString(),
              productCategory: product.productCategory,
              imageUrl: firstImage,
              quantity: product.productStocks,
              isSelected: _selectedProductIds.contains(product.productId),
              onSelected:
                  (selected) => _onProductSelected(selected, product.productId),
            );
          },
        );
      },
    );
  }
}
