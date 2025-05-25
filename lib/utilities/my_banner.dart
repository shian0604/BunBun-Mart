import 'package:flutter/material.dart';

class MyBanner extends StatefulWidget {
  final String imagepath;
  const MyBanner({
    super.key,
    required this.imagepath,
  });

  @override
  State<MyBanner> createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      child: Container(
        width: screenWidth,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(widget.imagepath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
