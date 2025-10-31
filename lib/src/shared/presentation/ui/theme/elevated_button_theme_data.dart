part of 'app_theme.dart';

final _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Palette.color333333),
    backgroundColor: WidgetStatePropertyAll(Palette.colorFF8900),
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 2),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 20),
    ),
    side: WidgetStatePropertyAll(
      BorderSide(color: Color(0xFF2E2E2E).hardcoded),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
);
