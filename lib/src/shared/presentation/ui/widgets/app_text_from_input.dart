import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormInput extends StatelessWidget {
  const AppTextFormInput({
    this.labelText,
    this.hintText,
    super.key,
    this.onSaved,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.maxLines,
    this.minLines,
    this.helperText,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.forceErrorText,
  });

  const AppTextFormInput.description({
    this.labelText,
    this.hintText,
    super.key,
    this.onSaved,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.helperText,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.forceErrorText,
  }) : maxLines = 2,
       minLines = 2;

  final void Function(String? value)? onSaved;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final TextEditingController? controller;
  final String? forceErrorText;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    if (labelText != null) {
      return Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              labelText!,
              style: TextStyle(fontSize: 16, height: 16 / 16, color: Colors.white24),
            ),
          ),
          TextFormField(
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hintText,
              helperText: helperText,
            ),
            onChanged: onChanged,
            onSaved: onSaved,
            inputFormatters: inputFormatters,
            validator: validator,
            maxLines: maxLines,
            minLines: minLines,
          ),
        ],
      );
    }
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
      forceErrorText: forceErrorText,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: helperText,
      ),
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      // style: WidgetStateTextStyle.resolveWith((states) {
      //   if (states.contains(WidgetState.disabled)) {
      //     return textTheme.bodyLarge!.copyWith(color: Colors.white);
      //   }
      //   return textTheme.bodyLarge!.copyWith(color: Colors.white);
      // }),
    );
  }
}
