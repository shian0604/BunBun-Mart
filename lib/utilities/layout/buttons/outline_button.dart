import 'package:flutter/material.dart';

class OutlineButton extends StatefulWidget {
  final String imagepath;
  final double imagewidth;
  final double imageheight;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  const OutlineButton({
    super.key,
    required this.imagepath,
    required this.imageheight,
    required this.imagewidth,
    this.height,
    this.width,
    this.onPressed
  });

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black, width: 3.0),
        borderRadius: BorderRadius.circular(50),
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
    );
  }
}
