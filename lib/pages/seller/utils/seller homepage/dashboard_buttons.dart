import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class DashboardButtons extends StatefulWidget {
  final String imagepath;
  final String text;
  final VoidCallback? onTap;
  const DashboardButtons({
    super.key,
    required this.imagepath,
    required this.text,
    this.onTap,
  });

  @override
  State<DashboardButtons> createState() => _DashboardButtonsState();
}

class _DashboardButtonsState extends State<DashboardButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [BunColors.navy, BunColors.beige],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
      
          image: DecorationImage(
                      image: AssetImage('assets/screentone/tone.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                      repeat: ImageRepeat.noRepeat,
                      opacity: 0.03,
                    ),
        ),
      
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(
              image: AssetImage(widget.imagepath),
              width: 64,
              height: 64,
            ),
            BTextBold(text: widget.text, color: BunColors.white),
          ],
        ),
      ),
    );
  }
}
