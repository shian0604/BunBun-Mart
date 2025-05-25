import 'package:flutter/material.dart';

class BunDivider extends StatelessWidget {
  final Color color;
  final double? thickness;
  final double indent;
  final double endIndent;
  const BunDivider({super.key, required this.color, required this.indent, required this. endIndent, this.thickness = 1.5,});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color, // Line color
      thickness: thickness, // Line thickness
      indent: indent, // Left padding
      endIndent: endIndent,
    );
  }
}
