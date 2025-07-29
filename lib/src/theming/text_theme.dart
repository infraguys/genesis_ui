part of 'app_theme.dart';

final TextTheme _baseTextTheme = TextTheme(
  headlineSmall: TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.bold),
  labelMedium: TextStyle(fontSize: 14, height: 24 / 14),
);

final _lightTextTheme = _baseTextTheme.copyWith();

final _darkTextTheme = _baseTextTheme.copyWith();
