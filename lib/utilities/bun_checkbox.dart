import 'package:flutter/material.dart';

class BunBoxCheckBox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  const BunBoxCheckBox({super.key, this.value, this.onChanged});

  @override
  State<BunBoxCheckBox> createState() => _BunBoxCheckBoxState();
}

class _BunBoxCheckBoxState extends State<BunBoxCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: Color(0xFF183B49),
      checkColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}

class BunCircleCBox extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final bool? tristate;
  const BunCircleCBox({super.key, this.value, this.onChanged, this.tristate});

  @override
  State<BunCircleCBox> createState() => _BunCircleCBoxState();
}

class _BunCircleCBoxState extends State<BunCircleCBox> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      tristate: widget.tristate ?? true,
      value: widget.value,
      onChanged: widget.onChanged,
      activeColor: Color(0xFF183B49),
      checkColor: Colors.white,
      shape: CircleBorder(),
    );
  }
}
