import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class SizePickerChips extends StatefulWidget {
  final List<String> availableSizes;
  final List<String> initialSelectedSizes; // New parameter
  final Function(List<String>) onSelectionChanged;

  const SizePickerChips({
    super.key,
    required this.availableSizes,
    required this.onSelectionChanged,
    this.initialSelectedSizes = const [], // Default to empty list
  });

  @override
  State<SizePickerChips> createState() => _SizePickerChipsState();
}

class _SizePickerChipsState extends State<SizePickerChips> {
  late List<String> selectedSizes; // Use late initialization

  @override
  void initState() {
    super.initState();
    selectedSizes = List.from(widget.initialSelectedSizes); // Initialize with the provided sizes
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 12.0,
          children: widget.availableSizes.map((size) {
            final isSelected = selectedSizes.contains(size);
            return FilterChip(
              label: Text(size),
              labelStyle: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: BunColors.black,
              ),
              selected: isSelected,
              selectedColor: Colors.grey.shade300,
              checkmarkColor: BunColors.navy,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedSizes.add(size);
                  } else {
                    selectedSizes.remove(size);
                  }
                  widget.onSelectionChanged(selectedSizes);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}