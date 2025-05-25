import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class QuantityInput extends StatefulWidget {
  final int initialValue;
  final int min;
  final int max;
  final Function(int) onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<int>? validator; // Change to int for validation

  const QuantityInput({
    super.key,
    required this.onChanged,
    this.initialValue = 1,
    this.min = 1,
    this.max = 999,
    this.controller,
    this.validator,
  });

  @override
  State<QuantityInput> createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialValue;
    widget.controller!.text = _quantity.toString();
  }

  void _updateQuantity(int value) {
    setState(() {
      _quantity = value.clamp(widget.min, widget.max);
      widget.controller!.text = _quantity.toString();
      widget.onChanged(_quantity);
    });
  }

  void _increment() => _updateQuantity(_quantity + 1);

  void _decrement() => _updateQuantity(_quantity - 1);

  void _onTextChanged(String value) {
    final int? parsed = int.tryParse(value);
    if (parsed != null) {
      _updateQuantity(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _quantity > widget.min ? _decrement : null,
        ),
        SizedBox(width: 5),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1.0, color: BunColors.black),
            ),
            child: TextFormField(
              controller: widget.controller,
              validator: (value) {
                final int? quantity = int.tryParse(value ?? '');
                if (quantity == null || quantity < widget.min || quantity > widget.max) {
                  return 'Quantity must be between ${widget.min} and ${widget.max}';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              onChanged: _onTextChanged,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _quantity < widget.max ? _increment : null,
        ),
      ],
    );
  }
}