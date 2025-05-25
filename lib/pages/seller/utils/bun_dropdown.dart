import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class BunDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String)? onChanged;

  const BunDropdown({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<BunDropdown> createState() => _BunDropdownState();
}

class _BunDropdownState extends State<BunDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue ?? (widget.items.isNotEmpty ? widget.items.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1.0, color: BunColors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: Image.asset("assets/icons/down.png", width: 16, height: 16),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          style: TextStyle(
            fontFamily: "Poppins",
            color: BunColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            }
          },
        ),
      ),
    );
  }
}