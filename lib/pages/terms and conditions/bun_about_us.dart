import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BunAboutUs extends StatelessWidget {
  const BunAboutUs({super.key});

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
                child: BunPageContainer(
                  color: BunColors.lightbeige,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BunBackButton(
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      BunbunHeader(
                        header: "About Us",
                        color: BunColors.black,
                      ),

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

                        child: BunDetailsText(
                          text:
                              "Welcome to BunBun Mart – a cozy corner of the internet lovingly crafted by a small team of passionate developers who believe every fur-parent deserves an easier, warmer way to care for their beloved companions. \n\nFrom the very first line of code to every fluffy feature you see, we poured our hearts, our late nights, and our endless love for animals into building not just a platform – but a soft little family space where buyers, sellers, and furry babies come together. \n\nWhether you're here to shop, sell, or simply sniff around, know that the BunBun family is here for you. Always.",
                          color: BunColors.white,
                        ),
                      ),

                      SizedBox(height: 16),
                      BTextBold(text: "OUR TEAM", color: BunColors.black, size: 16,),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          shape: BoxShape.circle
                        ),
                        child: BunCircularImage(imageheight: 120, imagewidth: 120, imagepath: "assets/profile/johann.jpg", borderColor: BunColors.lightbeige, borderWidth: 3,)),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: BTextBold(text: "Johann Francois Tanyag", color: BunColors.white),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: BunDetailsText(text: "The heart behind the code and the eye behind the design. As our main developer and designer, Johann blends technical skill with artistic vision, crafting BunBun Mart’s adorable, user-friendly look through years of experience as a digital artist.", color: BunColors.black),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          shape: BoxShape.circle
                        ),
                        child: BunCircularImage(imageheight: 120, imagewidth: 120, imagepath: "assets/profile/thea.jpg", borderColor: BunColors.lightbeige, borderWidth: 3,)),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: BTextBold(text: "Althea Maxene Viar", color: BunColors.white),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: BunDetailsText(text: "The co-founder and soul of the BunBun Family. Althea’s thoughtful ideas and nurturing touch laid the foundation for what BunBun Mart stands for today: warmth, trust, and community.", color: BunColors.black),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          shape: BoxShape.circle
                        ),
                        child: BunCircularImage(imageheight: 120, imagewidth: 120, imagepath: "assets/profile/kristel.jpg", borderColor: BunColors.lightbeige, borderWidth: 3,)),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: BunColors.navy,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: BTextBold(text: "Kristel Ramos", color: BunColors.white),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: BunDetailsText(text: "The inspiration behind our name and spirit. Kristel’s love for all things soft, cozy, and bunny-like gave birth to the term ‘BunBun Mart’ – a name that captures the essence of everything we do.", color: BunColors.black),
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
