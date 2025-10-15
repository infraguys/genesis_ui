part of 'app_theme.dart';

final _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    backgroundColor: WidgetStatePropertyAll(Color(0xFF1E1E1E).hardcoded),
    textStyle: WidgetStatePropertyAll(
      TextStyle(fontSize: 24),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 18),
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
