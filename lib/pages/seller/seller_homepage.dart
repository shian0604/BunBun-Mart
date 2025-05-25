import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/seller/features/add_product.dart';
import 'package:bunbunmart/pages/seller/seller_manageorders.dart';
import 'package:bunbunmart/pages/seller/seller_products.dart';
import 'package:bunbunmart/pages/seller/seller_profile.dart';
import 'package:bunbunmart/pages/seller/utils/product%20list/seller_verticalplist.dart';
import 'package:bunbunmart/pages/seller/utils/seller%20homepage/dashboard_buttons.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:bunbunmart/utilities/layout/texts/my_subtitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerHomePage extends StatefulWidget {
  const SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  String sellerId = FirebaseAuth.instance.currentUser!.uid; // If using auth

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
              Container(
                padding: EdgeInsets.all(10.0),
                width: BunSizeConfig.screenWidth,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [BunColors.navy, BunColors.gray, BunColors.beige],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),

                  image: DecorationImage(
                    image: AssetImage('assets/screentone/tone.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    repeat: ImageRepeat.noRepeat,
                    opacity: 0.03,
                  ),
                ),
                child: Column(
                  children: [
                    BunbunHeader(
                      header: "BunBun Mart",
                      color: BunColors.lightbeige,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: BunSizeConfig.screenWidth / 2 - 24,
                      child: DashboardButtons(
                        imagepath:
                            "assets/seller/buttons/db_manageproducts.png",
                        text: "Manage Products",
                        onTap: () {
                          Get.to(() => const SellerProducts());
                        },
                      ),
                    ),
                    SizedBox(
                      width: BunSizeConfig.screenWidth / 2 - 24,
                      child: DashboardButtons(
                        imagepath: "assets/seller/buttons/db_addproduct.png",
                        text: "Add Products",
                        onTap: () {
                          Get.to(
                            () => const AddProduct(),
                          ); // 👈 Using GetX navigation
                        },
                      ),
                    ),
                    SizedBox(
                      width: BunSizeConfig.screenWidth / 2 - 24,
                      child: DashboardButtons(
                        imagepath: "assets/seller/buttons/db_orders.png",
                        text: "Manage Orders",
                        onTap: () {
                          Get.to(() => const SellerManageOrders());
                        },
                      ),
                    ),
                    SizedBox(
                      width: BunSizeConfig.screenWidth / 2 - 24,
                      child: DashboardButtons(
                        imagepath: "assets/seller/buttons/db_viewprofile.png",
                        text: "View Profile",
                        onTap: () {
                          Get.to(() => const SellerProfile());
                        },
                      ),
                    ),
                  ],
                ),
              ),

              MySubtitle(subtitle: "Your Products"),
              SellerVerticalPlist(sellerId: sellerId,),
            ],
          ),
        ),
      ),
    );
  }
}
