import 'package:flutter/material.dart';

class BunCustomShape extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const BunCustomShape({
    super.key,
    required this.width,
    required this.height,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BunClipper(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}

class BunClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double curveHeight = size.height * 0.2; // 20% for top/bottom curve

    path.moveTo(0, curveHeight);
    path.quadraticBezierTo(0, 0, curveHeight, 0);
    path.lineTo(size.width - curveHeight, 0);
    path.quadraticBezierTo(size.width, 0, size.width, curveHeight);
    path.lineTo(size.width, size.height - curveHeight);
    path.quadraticBezierTo(size.width, size.height, size.width - curveHeight, size.height);
    path.lineTo(curveHeight, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - curveHeight);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
