part of 'app_theme.dart';

final _inputDecorationThemeData = InputDecorationThemeData(
  filled: true,
  fillColor: Colors.white.withValues(alpha: 0.05),
  hintStyle: TextStyle(color: Colors.white24),
  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
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
