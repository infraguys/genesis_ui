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
  });

  final void Function(String?)? onSaved;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;

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
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      readOnly: readOnly,
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
