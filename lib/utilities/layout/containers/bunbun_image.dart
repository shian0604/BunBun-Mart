import 'package:flutter/material.dart';

class BunBunImage extends StatelessWidget {
  final double imageheight;
  final double imagewidth;
  final String imagepath;
  const BunBunImage({
    super.key,
    required this.imageheight,
    required this.imagewidth,
    required this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageheight,
      width: imagewidth,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover),
      ),
    );
  }
}

class BunCircularImage extends StatelessWidget {
  final double imageheight;
  final double imagewidth;
  final String imagepath;
  final Color? borderColor;
  final double? borderWidth;

  const BunCircularImage({
    super.key,
    required this.imageheight,
    required this.imagewidth,
    required this.imagepath,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageheight,
      width: imagewidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            borderColor != null && borderWidth != null
                ? Border.all(color: borderColor!, width: borderWidth!)
                : null,
        image: DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover),
      ),
    );
  }
}
