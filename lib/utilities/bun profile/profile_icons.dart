import 'package:bunbunmart/pages/features/bun_editprofile.dart';
import 'package:bunbunmart/pages/features/bun_settings.dart';
import 'package:bunbunmart/pages/features/bun_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/layout/buttons/outline_button.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:get/get.dart';

class ProfileIcons extends StatefulWidget {
  const ProfileIcons({super.key});

  @override
  State<ProfileIcons> createState() => _ProfileIconsState();
}

class _ProfileIconsState extends State<ProfileIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              OutlineButton(
                imagepath: "assets/icons/edit.png",
                imageheight: 30,
                imagewidth: 30,
                onPressed: () =>  Get.to(() => const BunEditProfile()),
              ),
              SizedBox(height: 5.0),
              BunbunText(text: "Edit Profile", color: BunColors.black),
            ],
          ),
          SizedBox(width: 10.0),

          Flexible(
            flex: 3,
            child: Column(
              children: [
                OutlineButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BunBunSettings()),
                    );
                  },
                  imagepath: "assets/icons/setting.png",
                  imageheight: 30,
                  imagewidth: 30,
                  width: BunSizeConfig.screenWidth,
                ),
                SizedBox(height: 5.0),
                BunbunText(text: "Settings", color: BunColors.black),
              ],
            ),
          ),
          SizedBox(width: 10.0),

          Column(
            children: [
              OutlineButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BunWishlist()),
                  );
                },
                imagepath: "assets/icons/heart.png",
                imageheight: 30,
                imagewidth: 30,
              ),
              SizedBox(height: 5.0),
              BunbunText(text: "Wishlist", color: BunColors.black),
            ],
          ),
        ],
      ),
    );
  }
}
