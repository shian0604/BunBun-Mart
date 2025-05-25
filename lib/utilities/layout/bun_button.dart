import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class BunButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? radius;
  const BunButton({
    super.key,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.onTap,
    this.radius,
  });

  @override
  State<BunButton> createState() => _BunButtonState();
}

class _BunButtonState extends State<BunButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: Container(
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.radius ?? BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [BunColors.navy, BunColors.gray, BunColors.beige],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

          
        ),
      
        child: widget.child,
      ),
    );
  }
}

class BunWhiteButton extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  const BunWhiteButton({
    super.key,
    y,
    this.width,
    this.height,
    this.child,
    this.padding,
    this.onTap,
  });

  @override
  State<BunWhiteButton> createState() => _BunWhiteButtonState();
}

class _BunWhiteButtonState extends State<BunWhiteButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: Container(
        padding: widget.padding,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: BunColors.white,
        ),
      
        child: widget.child,
      ),
    );
  }
}
