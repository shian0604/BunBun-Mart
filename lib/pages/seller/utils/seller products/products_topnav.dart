import 'package:bunbunmart/pages/seller/features/add_product.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:get/get.dart';

class ProductsTopnav extends StatefulWidget {
  final ValueNotifier<bool> selectAllNotifier;
  const ProductsTopnav({super.key, required this.selectAllNotifier});

  @override
  State<ProductsTopnav> createState() => _ProductsTopnavState();
}

class _ProductsTopnavState extends State<ProductsTopnav> {
  bool _isAllSelected = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BunCircleCBox(
                tristate: false,
                value: _isAllSelected,
                onChanged: (val) {
                  setState(() {
                    _isAllSelected = val ?? false;
                    widget.selectAllNotifier.value = _isAllSelected;
                  });
                },
              ),
              BunbunSubText(subtext: "Select All", color: Colors.black),
            ],
          ),

          Wrap(
            children: [
              CircularIcons(
                onPressed: () {
                  Get.to(() => const AddProduct()); // 👈 Using GetX navigation
                },
                imagepath: "assets/seller/buttons/db_addproduct.png",
                color: BunColors.navy,
                imageheight: 20,
                imagewidth: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
