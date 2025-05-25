import 'package:flutter/material.dart';

class MySubtitle extends StatelessWidget {
  final String subtitle;
  final EdgeInsets padding;
  final Color containerColor;
  final VoidCallback? onPressed;
  const MySubtitle({
    super.key,
    required this.subtitle,
    this.padding = const EdgeInsets.symmetric(horizontal: 40.0),
    this.containerColor = const Color(0xFFF5F5F5),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: containerColor,
              ),
              child: IconButton(
                onPressed: onPressed ?? () {},
                icon: Image.asset(
                  "assets/icons/right-arrow.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
