import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunTermsContainer extends StatelessWidget {
  final String mainText;
  final String detailsText;
  const BunTermsContainer({super.key, required this.mainText, required this.detailsText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: BunSizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BunColors.beige,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: BTextBold(text: mainText, color: BunColors.black, size: 16),
          ),
          BunDetailsText(text: detailsText, color: BunColors.black),
        ],
      ),
    );
  }
}
