part of 'app_theme.dart';

final _inputDecorationThemeData = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white.withValues(alpha: 0.05),
  hintStyle: TextStyle(color: Color(0xFF7A7B7D).hardcoded),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
);
