import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/pages/main_page.dart';
import 'package:bunbunmart/utilities/bun%20wishlist/wishlist_filter.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/product%20list/vertical_productlist.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunWishlist extends StatefulWidget {
  const BunWishlist({super.key});

  @override
  State<BunWishlist> createState() => _BunWishlistState();
}

class _BunWishlistState extends State<BunWishlist> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Scaffold(
      body: Container(
        width: BunSizeConfig.screenWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BunColors.navy, BunColors.navy, BunColors.beige],
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, BunSizeConfig.blockSizeVertical * 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: BunPageContainer(
                          color: BunColors.white,
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: BunSizeConfig.blockSizeVertical * 20,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,

                                children: [
                                  BunBunFilter(
                                    text: "Sort",
                                    imagepath: "assets/icons/down.png",
                                  ),
                                  BunBunFilter(
                                    text: "Category",
                                    imagepath: "assets/icons/down.png",
                                  ),
                                  BunBunFilter(
                                    text: "Status",
                                    imagepath: "assets/icons/down.png",
                                  ),
                                  BunBunFilter(
                                    text: "Filter",
                                    imagepath: "assets/icons/filter.png",
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.0),
                              VerticalProductlist(padding: EdgeInsets.all(0)),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      width: BunSizeConfig.screenWidth,
                      height: 160,
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80.0),
                          bottomRight: Radius.circular(80.0),
                        ),
                        color: BunColors.navy,
                      ),

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: WhiteBackButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => MainPage(selectedIndex: 3),
                                  ),
                                );
                              },
                            ),
                          ),

                          BunbunHeader(
                            header: "Wishlist",
                            color: BunColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
