import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class SpaceBetweenText extends StatelessWidget {
  final String maintext;
  final String subtext;
  const SpaceBetweenText({super.key, required this.maintext, required this.subtext,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BTextBold(text: maintext, color: BunColors.black, size: 10,),
        BTextSmall(text: subtext, color: BunColors.black.withOpacity(0.8)),
      ],
    );
  }
}

class SellerInformation extends StatelessWidget {
  final String maintext;
  final String subtext;
  const SellerInformation({super.key, required this.maintext, required this.subtext,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BTextBold(text: maintext, color: BunColors.black,),
        BunbunText(text: subtext, color: BunColors.black.withOpacity(0.8), weight: FontWeight.w600,),
      ],
    );
  }
}