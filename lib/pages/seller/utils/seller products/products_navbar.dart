import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/bun_checkbox.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/social_icons.dart';
import 'package:flutter/material.dart';

class ProductsNavbar extends StatefulWidget {
  final VoidCallback? onDeletePressed;
  final VoidCallback? onEditPressed;
  final ValueNotifier<bool> selectAllNotifier;
  const ProductsNavbar({super.key, this.onDeletePressed, this.onEditPressed, required this.selectAllNotifier});

  @override
  State<ProductsNavbar> createState() => _ProductsNavbarState();
}

class _ProductsNavbarState extends State<ProductsNavbar> {
  bool _isAllSelected = false;
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        width: BunSizeConfig.screenWidth,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),

        child: Transform.translate(
          offset: Offset(0, 10),
          child: Column(
            children: [
              BunDivider(color: Colors.black, endIndent: 15, indent: 15),
              SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
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
                        BTextBold(text: "Select All", color: Colors.black),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      CircularIcons(
                        onPressed: widget.onEditPressed,
                        imagepath: "assets/seller/bunedit_w.png",
                        color: BunColors.navy,
                        imageheight: 16,
                        imagewidth: 16,
                        padding: EdgeInsets.all(0),
                      ),
                      SizedBox(width: 10.0),
                      CircularIcons(
                        onPressed: widget.onDeletePressed,
                        imagepath: "assets/seller/remove.png",
                        color: BunColors.navy,
                        imageheight: 16,
                        imagewidth: 16,
                        padding: EdgeInsets.all(0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
