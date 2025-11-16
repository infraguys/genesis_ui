import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:genesis/src/core/extensions/localized_build_context.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/app_snackbar.dart';
import 'package:google_fonts/google_fonts.dart';

class IdWidget extends StatelessWidget {
  const IdWidget({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'ID: ',
        children: [
          WidgetSpan(
            alignment: .middle,
            child: SelectableText(
              id,
              style: TextStyle(
                color: Colors.white,
                fontFamily: GoogleFonts.robotoMono().fontFamily,
              ),
            ),
          ),
          WidgetSpan(child: const SizedBox(width: 8)),
          WidgetSpan(
            alignment: .middle,
            child: IconButton(
              icon: Icon(Icons.copy, color: Colors.white, size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: id));
                final msg = context.$.msgCopiedToClipboard(id);
                ScaffoldMessenger.of(context).showSnackBar(AppSnackBar.success(msg));
              },
            ),
          ),
        ],
      ),
    );
  }
}
