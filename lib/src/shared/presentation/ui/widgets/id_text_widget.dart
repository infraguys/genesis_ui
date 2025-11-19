import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdTextWidget extends StatelessWidget {
  const IdTextWidget({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      id,
      style: TextStyle(
        color: Colors.white,
        fontFamily: GoogleFonts.robotoMono().fontFamily,
      ),
    );
  }
}
