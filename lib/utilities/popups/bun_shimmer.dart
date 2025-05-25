import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class BunShimmerEffect extends StatelessWidget {
  const BunShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.radius = 15,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: BunColors.beige,
      highlightColor: BunColors.navy,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
