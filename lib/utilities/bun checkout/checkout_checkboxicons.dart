import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/containers/bunbun_image.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class CheckoutRadioIcon extends StatelessWidget {
  final String imagepath;
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String?>? onChanged;

  const CheckoutRadioIcon({
    super.key,
    required this.imagepath,
    required this.text,
    required this.value,
    required this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          focusColor: BunColors.navy,
          activeColor: BunColors.navy,
          
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: 5.0),
        BunBunImage(
          imageheight: 20,
          imagewidth: 20,
          imagepath: imagepath,
        ),
        const SizedBox(width: 10.0),
        BunbunText(text: text, color: Colors.black),
      ],
    );
  }
}
