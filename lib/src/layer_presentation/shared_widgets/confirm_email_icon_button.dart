import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/theming/palette.dart';

class ConfirmEmailIconButton extends StatelessWidget {
  const ConfirmEmailIconButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ElevatedButton.icon(
      icon: Icon(Icons.mark_email_read_outlined, color: Palette.color6DCF91),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Palette.color333333),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
      ),
      label: Text(
        context.$.confirmEmail,
        style: textTheme.headlineSmall!.copyWith(height: 20 / 14) + Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
