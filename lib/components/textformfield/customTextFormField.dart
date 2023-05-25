import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  TextInputAction? textInputAction;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    Key? key,
    required this.controller,
    this.textInputAction,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
    );
  }
}
