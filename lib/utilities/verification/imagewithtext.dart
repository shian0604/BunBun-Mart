import 'package:flutter/material.dart';
import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';

class ImageWithText extends StatelessWidget {
  final String imagepath;
  final String title;
  final String text;
  final String? subtext;
  const ImageWithText({super.key, required this.imagepath, required this.title, required this.text, this.subtext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BunBunImage(
          imageheight: 240,
          imagewidth: 240,
          imagepath: imagepath,
        ),

        SizedBox(height: 16),
        BTextBold(text: title, color: BunColors.black, size: 24),
        if (subtext != null) ...[
          const SizedBox(height: 8),
          BTextBold(text: subtext!, color: BunColors.black),
        ],
        SizedBox(height: 8),
        OnBoardingText(text: text, color: BunColors.black),
      ],
    );
  }
}
