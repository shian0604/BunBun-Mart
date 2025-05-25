import 'package:bunbunmart/data/color_helper_function.dart';
import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<String> productColors;
  final Function(String) onColorSelected;

  const ColorSelector({
    super.key,
    required this.productColors,
    required this.onColorSelected,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  String? selectedColorName;

  @override
  void initState() {
    super.initState();
    if (widget.productColors.isNotEmpty) {
      selectedColorName = widget.productColors[0];
      widget.onColorSelected(selectedColorName!); // Call on init
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.productColors.map((colorName) {
          final isSelected = selectedColorName == colorName;
          final color = getColorFromName(colorName);
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColorName = colorName;
              });
              widget.onColorSelected(colorName); // Trigger controller method
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color,
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
