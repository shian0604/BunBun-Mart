import 'package:flutter/material.dart';

class UnderlineInputfield extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final String? suffixpath;
  final VoidCallback? suffixAction;
  final String? altSuffixPath;
  final bool? isToggled;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator; 

  const UnderlineInputfield({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.suffixpath,
    this.altSuffixPath,
    this.isToggled,
    this.suffixAction,
    this.controller,
    this.validator,
  });

  @override
  State<UnderlineInputfield> createState() => _UnderlineInputfieldState();
}

class _UnderlineInputfieldState extends State<UnderlineInputfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.obscureText, // If true, hides password input
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12, // Increased size for better readability
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF183B49), width: 1.5),
          ),

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
