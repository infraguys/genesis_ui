import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    required this.controller,
    super.key,
    this.hintText,
  }) : _maxLines = 1,
       _minLines = 1;

  const AppTextInput.multiLine({
    required this.controller,
    required this.hintText,
    super.key,
    final int? maxLines,
    final int? minLines,
  }) : _maxLines = maxLines,
       _minLines = minLines;

  final TextEditingController controller;
  final String? hintText;
  final int? _maxLines;
  final int? _minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: _maxLines,
      minLines: _minLines,
      style: TextStyle(color: Colors.white, fontSize: 16, height: 20 / 16),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        hintText: hintText,
        // todo: вынести цвета в тему
        hintStyle: TextStyle(color: Colors.white24),
      ),
    );
  }
}
