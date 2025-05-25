import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/buttons/back_button.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  const SettingsRow({super.key, required this.text, this.onPressed});

  @override
  State<SettingsRow> createState() => _SettingsRowState();
}

class _SettingsRowState extends State<SettingsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BTextBold(text: widget.text, color: BunColors.black),
        BunProceedButton(onPressed: widget.onPressed ?? () {},),
      ],
    );
  }
}
