import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormInput extends StatelessWidget {
  const AppTextFormInput({
    required this.labelText,
    required this.hintText,
    super.key,
    this.onSaved,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
  });

  final void Function(String?)? onSaved;
  final String? initialValue;
  final String labelText;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            labelText,
            style: TextStyle(fontSize: 12, color: Colors.white24),
          ),
        ),
        TextFormField(
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            helperText: '',
          ),
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
        ),
      ],
    );
  }
}
