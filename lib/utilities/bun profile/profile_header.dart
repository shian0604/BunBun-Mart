import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_circularcontainer.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    double circleSize =
        BunSizeConfig.screenWidth > BunSizeConfig.screenHeight
            ? BunSizeConfig.screenHeight
            : BunSizeConfig.screenWidth;

    return BunbunCircularContainer(
      child: Transform.translate(
        offset: Offset(0, circleSize * 0.15),
        child: Center(
          child: BunbunHeader(header: "Profile", color: BunColors.beige),
        ),
      ),
    );
  }
}
