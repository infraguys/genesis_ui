import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/theming/palette.dart';
import 'package:go_router/go_router.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({required this.message, super.key, this.onDelete});

  final String message;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: context.pop,
          child: Text(context.$.cancel),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Palette.colorF04C4C),
          onPressed: () {
            context.pop();
            onDelete?.call();
          },
          child: Text(context.$.ok),
        ),
      ],
    );
    ;
  }
}
