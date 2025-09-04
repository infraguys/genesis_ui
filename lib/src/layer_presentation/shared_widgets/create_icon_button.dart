import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/theming/palette.dart';

class CreateIconButton extends StatelessWidget {
  const CreateIconButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
      ),
      label: Text(context.$.create, style: textTheme.labelLarge!.w700 + Palette.color1B1B1D),
      icon: Icon(Icons.add, color: Palette.color1B1B1D),
      onPressed: onPressed,
    );
  }
}
