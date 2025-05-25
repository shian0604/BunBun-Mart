import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:flutter/material.dart';

class BunStars extends StatefulWidget {
  const BunStars({super.key});

  @override
  State<BunStars> createState() => _BunStarsState();
}

class _BunStarsState extends State<BunStars> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: "assets/icons/sparkle.png",
        ),
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: "assets/icons/sparkle.png",
        ),
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: "assets/icons/sparkle.png",
        ),
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: "assets/icons/sparkle.png",
        ),
        BunBunImage(
          imageheight: 16,
          imagewidth: 16,
          imagepath: "assets/icons/sparkle.png",
        ),
      ],
    );
  }
}
