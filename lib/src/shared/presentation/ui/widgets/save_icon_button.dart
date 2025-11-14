import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class SaveIconButton extends StatelessWidget {
  const SaveIconButton({this.label, this.onPressed, super.key});

  final VoidCallback? onPressed;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
        padding: WidgetStatePropertyAll(
          .symmetric(horizontal: 20, vertical: 20),
        ),
      ),
      label: Text(label ?? context.$.save, style: textTheme.labelLarge!.w700 + Palette.color1B1B1D),
      icon: Icon(Icons.save_outlined, color: Palette.color1B1B1D),
      onPressed: onPressed,
    );
  }
}
