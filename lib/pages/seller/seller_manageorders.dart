import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/seller_orderlist.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class SellerManageOrders extends StatefulWidget {
  const SellerManageOrders({super.key});

  @override
  State<SellerManageOrders> createState() => _SellerManageOrdersState();
}

class _SellerManageOrdersState extends State<SellerManageOrders> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      backgroundColor: BunColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: BunBunContainer(
                  child: Center(
                    child: BunbunHeader(
                      header: "Manage Products",
                      color: BunColors.lightbeige,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                width: BunSizeConfig.screenWidth,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(children: [SellerOrderlist()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
