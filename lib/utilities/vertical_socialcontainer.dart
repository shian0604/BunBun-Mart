import 'package:flutter/material.dart';

class VerticalSocialContainer extends StatefulWidget {
  final String imagepath;
  final String label;
  const VerticalSocialContainer({
    super.key,
    required this.imagepath,
    required this.label,
  });

  @override
  State<VerticalSocialContainer> createState() =>
      _VerticalSocialContainerState();
}

class _VerticalSocialContainerState extends State<VerticalSocialContainer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.imagepath, width: 24, height: 24, fit: BoxFit.cover,),
              SizedBox(width: 10), // Space between icon and text
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
