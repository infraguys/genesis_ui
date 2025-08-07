part of 'app_theme.dart';

final TextTheme _baseTextTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 32, height: 20 / 14, fontWeight: FontWeight.bold),
  headlineSmall: TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.bold),
  labelLarge: TextStyle(fontSize: 14, height: 20 / 14),
  labelMedium: TextStyle(fontSize: 14, height: 20 / 14),
);

final _lightTextTheme = _baseTextTheme.copyWith();

final _darkTextTheme = _baseTextTheme.copyWith(
  headlineLarge: _baseTextTheme.headlineLarge! + Colors.white,
  headlineSmall: _baseTextTheme.headlineSmall! + Colors.white,
  labelLarge: _baseTextTheme.labelLarge! + Colors.white,
  labelMedium: _baseTextTheme.labelMedium! + Colors.white,
);
