import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class BunbunHeader extends StatelessWidget {
  final String header;
  final Color color;
  const BunbunHeader({super.key, required this.header, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
        fontFamily: "DeliusSwashCaps",
        fontSize: 32,
        color: color,
      ),
    );
  }
}

class BunSubHeader extends StatelessWidget {
  final String header;
  final Color color;
  const BunSubHeader({super.key, required this.header, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
        fontFamily: "DeliusSwashCaps",
        fontSize: 24,
        color: color,
      ),
    );
  }
}

class BunbunSubText extends StatelessWidget {
  final String subtext;
  final Color color;
  final TextAlign? align;
  final double? size;
  const BunbunSubText({
    super.key,
    required this.subtext,
    required this.color,
    this.align,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      subtext,
      textAlign: align ?? TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class BunbunText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight? weight;
  const BunbunText({
    super.key,
    required this.text,
    required this.color,
    this.size = 12,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        color: color,
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}

class OnBoardingText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight? weight;
  const OnBoardingText({
    super.key,
    required this.text,
    required this.color,
    this.size = 12,
    this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        color: color,
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}

class BunDetailsText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  const BunDetailsText({
    super.key,
    required this.text,
    required this.color,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      maxLines: 30,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class BTextBold extends StatelessWidget {
  final String text;
  final Color color;
  final double? size;
  final int? maxLiness;
  const BTextBold({
    super.key,
    required this.text,
    required this.color,
    this.size = 12,
    this.maxLiness = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLiness,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: size,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final double? size;
  const GradientText({super.key, required this.text, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [BunColors.navy, BunColors.gray, BunColors.beige],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),

      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: size,
          color:
              Colors.white, // color must be set to white to show the gradient
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class BTextSmall extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight? weight;
  final int? maxLines;
  const BTextSmall({
    super.key,
    required this.text,
    required this.color,
    this.weight,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 8,
        color: color,
        fontWeight: weight ?? FontWeight.w400,
      ),
    );
  }
}
