import 'package:flutter/material.dart';

class CircularIcons extends StatefulWidget {
  final String imagepath;
  final double imageheight;
  final double imagewidth;
  final Color? color;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;

  const CircularIcons({
    super.key,
    required this.imagepath,
    required this.imageheight,
    required this.imagewidth,
    this.color = Colors.white,
    this.height,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 10.0,),
    this.onPressed,
  });

  @override
  State<CircularIcons> createState() => _CircularIconsState();
}

class _CircularIconsState extends State<CircularIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: IconButton(
          icon: Image.asset(
            widget.imagepath,
            width: widget.imagewidth,
            height: widget.imageheight,
            fit: BoxFit.cover,
            
          ),
          onPressed: widget.onPressed ?? () {},
        ),
      ),
    );
  }
}


