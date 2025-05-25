import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.sizes.isNotEmpty) {
      selectedSize = widget.sizes[0];
      widget.onSizeSelected(selectedSize!); // Call on init
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.sizes.map((size) {
          bool isSelected = selectedSize == size;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
                widget.onSizeSelected(size); // Trigger controller method
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                height: 36,
                width: 60,
                decoration: BoxDecoration(
                  color: isSelected ? BunColors.navy : BunColors.beige,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BTextBold(
                    text: size,
                    color: isSelected ? BunColors.white : BunColors.black,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
