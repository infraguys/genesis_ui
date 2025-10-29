import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';
import 'package:go_router/go_router.dart';

class AppModalDialog extends StatelessWidget {
  const AppModalDialog({
    required this.content,
    super.key,
    this.onPressed,
    this.onCancel,
  });

  final Widget content;
  final VoidCallback? onPressed;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            context.pop();
          },
          child: Text(context.$.cancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Palette.color6DCF91),
          onPressed: onPressed,
          child: Text(context.$.ok),
        ),
      ],
    );
  }
}
