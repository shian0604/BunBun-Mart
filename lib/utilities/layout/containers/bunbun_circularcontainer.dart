import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';

class BunbunCircularContainer extends StatelessWidget {
  final Widget? child;
  const BunbunCircularContainer({super.key, this.child,});

  @override
  Widget build(BuildContext context) {
    double circleSize =
        BunSizeConfig.screenWidth > BunSizeConfig.screenHeight
            ? BunSizeConfig.screenHeight
            : BunSizeConfig.screenWidth;

    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            BunColors.navy,
            BunColors.navy,
            BunColors.beige,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
