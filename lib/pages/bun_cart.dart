import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/bun%20cart/cart_bottomnavbar.dart';
import 'package:bunbunmart/utilities/bun%20cart/cart_header.dart';
import 'package:bunbunmart/utilities/layout/bun_divider.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_container.dart';
import 'package:bunbunmart/utilities/layout/product%20list/horizontal_productlist.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunBunCart extends StatefulWidget {
  const BunBunCart({super.key});

  @override
  State<BunBunCart> createState() => _BunBunCartState();
}

class _BunBunCartState extends State<BunBunCart> {
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
                      header: "BunBun Cart",
                      color: BunColors.lightbeige,
                    ),
                  ),
                ),
              ),
        
              CartHeader(),
              Transform.translate(
                offset: Offset(0, -10),
                child: BunDivider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
              ),
        
              HorizontalProductlist(),
              
            ],
          ),
        ),
      ),

      bottomNavigationBar: CartBottomnavbar(),
    );
  }
}
