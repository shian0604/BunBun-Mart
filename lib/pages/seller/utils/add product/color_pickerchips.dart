import 'package:bunbunmart/models/bun_colors.dart';
import 'package:bunbunmart/utilities/layout/texts/bun_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bunbunmart/data/controller/seller/product_controller.dart';

class ColorPickerChips extends StatelessWidget {
  final List<String> availableColors;
  final Function(List<String>) onSelectionChanged;
  final TextEditingController? textcontroller;
  final FormFieldValidator<String>? validator;

  const ColorPickerChips({
    super.key,
    required this.availableColors,
    required this.onSelectionChanged,
    this.textcontroller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find(); // Get the instance of ProductController

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Wrap(
            spacing: 8.0,
            runSpacing: 12.0,
            children: availableColors.map((color) {
              final isSelected = controller.selectedColors.contains(color);
              return FilterChip(
                label: Text(color),
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
                  if (selected) {
                    controller.selectedColors.add(color);
                  } else {
                    controller.selectedColors.remove(color);
                  }
                  onSelectionChanged(controller.selectedColors.toList());
                },
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: BunColors.black),
                ),
                child: TextFormField(
                  controller: textcontroller,
                  validator: validator,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                    hintText: "Add a Color",
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                controller.addCustomColor(context); // Call the addCustomColor method
                onSelectionChanged(controller.selectedColors.toList()); // Update the selection
              },
              style: ElevatedButton.styleFrom(backgroundColor: BunColors.navy),
              child: const BTextBold(text: "Add", color: BunColors.white),
            ),
          ],
        ),
      ],
    );
  }
}