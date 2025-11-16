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
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
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
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
  }) : maxLines = 2,
       minLines = 2;

  const AppTextFormInput.password({
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
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
  }) : maxLines = 1,
       minLines = 1;

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
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    if (labelText != null) {
      return Column(
        spacing: 4.0,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: const .only(left: 18),
            child: Text(
              labelText!,
              style: TextStyle(fontSize: 16, height: 16 / 16, color: Colors.white24),
            ),
          ),
          TextFormField(
            initialValue: initialValue,
            autovalidateMode: .onUserInteraction,
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
      autovalidateMode: .onUserInteraction,
      readOnly: readOnly,
      forceErrorText: forceErrorText,
      decoration: InputDecoration(
        hintText: hintText,
        helperText: helperText,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: Padding(padding: const .only(right: 8.0), child: suffixIcon),
      ),
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      validator: validator,
      maxLines: maxLines,
      minLines: minLines,
      obscureText: obscureText,
      focusNode: focusNode,

      // style: WidgetStateTextStyle.resolveWith((states) {
      //   if (states.contains(WidgetState.disabled)) {
      //     return textTheme.bodyLarge!.copyWith(color: Colors.white);
      //   }
      //   return textTheme.bodyLarge!.copyWith(color: Colors.white);
      // }),
    );
  }
}
