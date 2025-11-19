import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/clipboard_copy_btn.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/id_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class IdWidget extends StatelessWidget {
  const IdWidget({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'ID: ',
        style: TextStyle(color: Colors.white),
        children: [
          WidgetSpan(
            alignment: .middle,
            child: IdTextWidget(id: id),
          ),
          WidgetSpan(child: const SizedBox(width: 8)),
          WidgetSpan(
            alignment: .middle,
            child: ClipboardCopyButton(value: id),
          ),
        ],
      ),
    );
  }
}
