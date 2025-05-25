import 'package:flutter/material.dart';
import 'package:bunbunmart/utilities/social_icons.dart';

class BunBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  const BunBackButton({super.key, this.onPressed});

  @override
  State<BunBackButton> createState() => _BunBackButtonState();
}

class _BunBackButtonState extends State<BunBackButton> {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 3.14,
      child: CircularIcons(
        imagepath: "assets/icons/right-arrow.png",
        imageheight: 12,
        imagewidth: 12,
        color: Colors.transparent,
        onPressed: widget.onPressed ?? () {},
      ),
    );
  }
}

class WhiteBackButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Color? color;
  const WhiteBackButton({super.key, this.onPressed, this.color});

  @override
  State<WhiteBackButton> createState() => _WhiteBackButtonState();
}

class _WhiteBackButtonState extends State<WhiteBackButton> {
  @override
  Widget build(BuildContext context) {
    return CircularIcons(
      imagepath: "assets/icons/white-arrow.png",
      imageheight: 16,
      imagewidth: 16,
      color: widget.color ?? Colors.transparent,
      onPressed: widget.onPressed ?? () {},
    );
  }
}

class BunProceedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  const BunProceedButton({super.key, this.onPressed});

  @override
  State<BunProceedButton> createState() => _BunProceedButton();
}

class _BunProceedButton extends State<BunProceedButton> {
  @override
  Widget build(BuildContext context) {
    return CircularIcons(
      imagepath: "assets/icons/right-arrow.png",
      imageheight: 12,
      imagewidth: 12,
      color: Colors.transparent,
      onPressed: widget.onPressed ?? () {},
    );
  }
}
