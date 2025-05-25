import 'package:bunbunmart/models/bun_colors.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final String? imagepath;
  final String? suffixpath;
  final VoidCallback? suffixAction;
  final String? altSuffixPath;
  final bool? isToggled;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final BorderRadius? radius;
  final bool showBorder;

  const MyInputField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.imagepath,
    this.suffixpath,
    this.altSuffixPath,
    this.isToggled,
    this.suffixAction,
    this.controller,
    this.validator,
    this.radius,

    this.showBorder = false,
  });

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.radius ?? BorderRadius.circular(10),
        border: widget.showBorder
            ? Border.all(color: Colors.black12, width: 1)
            : null,
      ),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12, // Increased size for better readability
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20.0),
          labelText: widget.labelText,

          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),

          prefixIcon:
              widget.imagepath != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        widget.imagepath!,
                        width: 12,
                        height: 12,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  : null,

          suffixIcon:
              widget.suffixpath != null
                  ? Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 8.0),
                    child: GestureDetector(
                      onTap: widget.suffixAction,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          widget.isToggled == true &&
                                  widget.altSuffixPath != null
                              ? widget.altSuffixPath!
                              : widget.suffixpath!,
                          width: 12,
                          height: 12,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}

class TransparentInputField extends StatefulWidget {
  final String hintText;
  final double width;
  final double? height;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const TransparentInputField({
    super.key,
    required this.hintText,
    required this.width,
    this.height,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  State<TransparentInputField> createState() => _TransparentInputFieldState();
}

class _TransparentInputFieldState extends State<TransparentInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        border: Border.all(width: 2.0, color: BunColors.black),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20.0),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}


class BorderInputField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final String? imagepath;
  final String? suffixpath;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;

  const BorderInputField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.imagepath,
    this.suffixpath,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  State<BorderInputField> createState() => _BorderInputFieldState();
}

class _BorderInputFieldState extends State<BorderInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.0, color: BunColors.black),
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12, // Increased size for better readability
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          hintText: widget.hintText,

          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),

          prefixIcon:
              widget.imagepath != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        widget.imagepath!,
                        width: 12,
                        height: 12,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  : null,

          suffixIcon:
              widget.suffixpath != null
                  ? Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 8.0),
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        widget.suffixpath!,
                        width: 12,
                        height: 12,
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  : null,
        ),
      ),
    );
  }
}

class DescriptionInputField extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  const DescriptionInputField({super.key, this.controller, this.validator});

  @override
  State<DescriptionInputField> createState() => _DescriptionInputFieldState();
}

class _DescriptionInputFieldState extends State<DescriptionInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.0, color: BunColors.black),
      ),
      child: TextFormField(
        maxLines: 10,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12, // Increased size for better readability
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 30.0,
          ),
          hintText: "Description",

          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
