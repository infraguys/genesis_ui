import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';

class ClipboardCopyButton extends StatelessWidget {
  const ClipboardCopyButton({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.copy, color: Colors.white, size: 18),
      onPressed: () {
        Clipboard.setData(ClipboardData(text: value));
        final msg = context.$.msgCopiedToClipboard(value);
        ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.success(msg));
      },
    );
  }
}
