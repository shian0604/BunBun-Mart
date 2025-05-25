import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunAboutBunbunMart extends StatelessWidget {
  const BunAboutBunbunMart({super.key});

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
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: BunSizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [BunColors.navy, BunColors.gray, BunColors.beige],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: WhiteBackButton(
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          Text(
                            "About BunBun Mart",
                            style: TextStyle(
                              color: BunColors.white,
                              fontSize: 24,
                              fontFamily: "DeliusSwashCaps",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      BunCircularImage(
                        imageheight: 220,
                        imagewidth: 220,
                        imagepath: "assets/logo/2.0x/BunBunMartLogo.png",
                      ),

                      Transform.translate(
                        offset: Offset(0, -20),
                        child: Column(
                          children: [
                            BTextBold(text: "BunBun Mart", color: BunColors.white, size: 24,),
                            BunDetailsText(text: "Where fluffy dreams and paw-sitive shopping come true! 🐾🌸", color: BunColors.white),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              

              Padding(
                padding: const EdgeInsets.only(left:  20.0, right: 20.0, bottom: 20.0),
                child: BunPageContainer(
                  color: BunColors.lightbeige,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      BunDivider(
                        color: BunColors.black,
                        indent: 0,
                        endIndent: 0,
                      ),
                      SizedBox(height: 8),

                      BunbunText(
                        text: "⊹₊⟡⋆.𖥔 ݁ ˖⊹₊⟡⋆₊ ⊹",
                        color: BunColors.navy,
                        size: 18,
                      ),
                      SizedBox(height: 8),

                      Container(
                        padding: EdgeInsets.all(20),
                        width: BunSizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: BunColors.navy,
                        ),

                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BTextBold(text: "🌿 Our Story", color: BunColors.white, size: 18,)),
                            BunDetailsText(
                              text:
                                  " Once upon a paw-print in 2024, we were just a cozy little digital burrow known as Kunehouse — a humble marketplace created out of love for pets and the fur parents who care for them. \n  What started as a small project turned into a full-blown passion! We dreamed of a place where pet lovers could find everything they needed in just a few happy hops. So, we grew, fluffed our fur, and became BunBun Mart — a safe, cuddly corner of the internet just for pets and their loving hoomans. \n We’re still young — just a baby bun in the big world — but our hearts are full and our dreams are big. 💕",
                              color: BunColors.white,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),

                      Container(
                        padding: EdgeInsets.all(20),
                        width: BunSizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: BunColors.navy,
                        ),

                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BTextBold(text: "🎯 Our Mission", color: BunColors.white, size: 18,)),
                            BunDetailsText(
                              text:
                                  "At BunBun Mart, our mission is simple but sweet: To make shopping for your fur babies easier, happier, and full of love.\n We promise:\n• 🛍️ A paw-sitive shopping experience, whether you’re buying or selling\n• A carefully curated selection of pet products, from shampoos to treats\n• A family-first community where all fur parents feel welcome\n• Safe, secure, and easy-to-use features so you can shop without worry\n The BunBun Family is here to make sure your fur babies are spoiled with care — one cart, cuddle, and click at a time!",
                              color: BunColors.white,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
