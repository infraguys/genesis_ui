import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    super.key,
    this.hintText,
    this.validator,
  }) : _maxLines = 1,
       _minLines = 1;

  const AppTextInput.multiLine({
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    super.key,
    final int? maxLines,
    final int? minLines,
  }) : suffixIcon = null,
       _maxLines = maxLines,
       _minLines = minLines;

  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  final Icon? suffixIcon;
  final int? _maxLines;
  final int? _minLines;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorErrorColor: Colors.white,
      cursorColor: Colors.white,
      controller: controller,
      maxLines: _maxLines,
      minLines: _minLines,
      autovalidateMode: AutovalidateMode.onUnfocus,
      obscureText: obscureText,
      style: TextStyle(fontSize: 16, height: 20 / 16),
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
      validator: validator,
    );
  }
}
