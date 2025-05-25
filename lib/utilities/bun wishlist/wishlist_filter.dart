import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunBunFilter extends StatefulWidget {
  final String text;
  final String imagepath;
  const BunBunFilter({super.key, required this.text, required this.imagepath,});

  @override
  State<BunBunFilter> createState() => _BunBunFilterState();
}

class _BunBunFilterState extends State<BunBunFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BTextBold(text: widget.text, color: BunColors.black),
        SizedBox(width: 5.0),
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: widget.imagepath,
        ),
      ],
    );
  }
}
