import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/models/size_configs.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunButton extends StatefulWidget {
  final String text;
  const BunButton({super.key, required this.text});

  @override
  State<BunButton> createState() => _BunButtonState();
}

class _BunButtonState extends State<BunButton> {
  @override
  Widget build(BuildContext context) {
    BunSizeConfig.init(context);
    return Container(
      width: BunSizeConfig.screenWidth,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: const LinearGradient(
          colors: [Color(0xFF183B49), Color(0xFFD3CAAB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: BTextBold(text: widget.text, color: BunColors.white,)
      ),
    );
  }
}
