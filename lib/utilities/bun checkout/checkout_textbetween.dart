import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class CheckoutTextBetween extends StatefulWidget {
  final String text1;
  final String text2;
  final FontWeight? weight;
  const CheckoutTextBetween({super.key, required this.text1, required this.text2, this.weight});

  @override
  State<CheckoutTextBetween> createState() => _CheckoutTextBetweenState();
}

class _CheckoutTextBetweenState extends State<CheckoutTextBetween> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BTextBold(text: widget.text1, color: BunColors.black),
        BunbunText(text: widget.text2, color: BunColors.navy, weight: widget.weight, ),
      ],
    );
  }
}
