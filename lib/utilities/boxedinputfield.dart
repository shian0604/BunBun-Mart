import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class BoxedInputField extends StatefulWidget {
  final int length;
  final void Function(String)? onCompleted;

  const BoxedInputField({super.key, this.length = 6, this.onCompleted});

  @override
  State<BoxedInputField> createState() => _BoxedInputFieldState();
}

class _BoxedInputFieldState extends State<BoxedInputField> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.length, (_) => TextEditingController());
    focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void handleInput(String value, int index) {
    if (value.length == 1 && index < widget.length - 1) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    String code = controllers.map((c) => c.text).join();
    if (code.length == widget.length && !code.contains('')) {
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: BunColors.navy, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
            
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 18,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: BunColors.navy,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),

            onChanged: (value) => handleInput(value, index),
          ),
        );
      }),
    );
  }
}