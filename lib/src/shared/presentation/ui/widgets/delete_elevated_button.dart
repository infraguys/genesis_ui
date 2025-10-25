import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class DeleteElevatedButton extends StatelessWidget {
  const DeleteElevatedButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return ElevatedButton.icon(
      icon: Icon(CupertinoIcons.delete, color: Palette.colorF04C4C),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Palette.color333333),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
      ),
      label: Text(context.$.delete, style: textTheme.headlineSmall!.copyWith(height: 20 / 14) + Colors.white),
      onPressed: onPressed,
    );
  }
}
