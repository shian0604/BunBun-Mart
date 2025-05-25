import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class BunOnboardingPage extends StatefulWidget {
  final String imagepath;
  final String title;
  final String text;
  const BunOnboardingPage({
    super.key,
    required this.imagepath,
    required this.title,
    required this.text,
  });

  @override
  State<BunOnboardingPage> createState() => _BunOnboardingPageState();
}

class _BunOnboardingPageState extends State<BunOnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(widget.imagepath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 12.0),
          BTextBold(text: widget.title, color: BunColors.black, size: 24),
          SizedBox(height: 6.0),
          OnBoardingText(text: widget.text, color: BunColors.black, size: 12, weight: FontWeight.w500,),
        ],
      ),
    );
  }
}
