part of 'app_theme.dart';

final TextTheme _baseTextTheme = TextTheme(
  displayLarge: TextStyle(),
  displayMedium: TextStyle(),
  displaySmall: TextStyle(),
  headlineLarge: TextStyle(fontSize: 32, height: 20 / 14, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(),
  headlineSmall: TextStyle(fontSize: 14, height: 20 / 14, fontWeight: FontWeight.bold),
  labelLarge: TextStyle(fontSize: 14, height: 20 / 14),
  labelMedium: TextStyle(fontSize: 14, height: 20 / 14),
  labelSmall: TextStyle(),
  bodyLarge: TextStyle(),
  bodyMedium: TextStyle(),
  bodySmall: TextStyle(),
  titleLarge: TextStyle(),
  titleMedium: TextStyle(),
  titleSmall: TextStyle(),
);

final _lightTextTheme = _baseTextTheme.copyWith();

final _darkTextTheme = _baseTextTheme.copyWith(
  displayLarge: _baseTextTheme.displayLarge! + Colors.white,
  displayMedium: _baseTextTheme.displayMedium! + Colors.white,
  displaySmall: _baseTextTheme.displaySmall! + Colors.white,
  headlineLarge: _baseTextTheme.headlineLarge! + Colors.white,
  headlineMedium: _baseTextTheme.headlineMedium! + Colors.white,
  headlineSmall: _baseTextTheme.headlineSmall! + Colors.white,
  labelLarge: _baseTextTheme.labelLarge! + Colors.white,
  labelMedium: _baseTextTheme.labelMedium! + Colors.white,
  labelSmall: _baseTextTheme.labelSmall! + Colors.white,
  bodyLarge: _baseTextTheme.bodyLarge! + Colors.white,
  bodyMedium: _baseTextTheme.bodyMedium! + Colors.white,
  bodySmall: _baseTextTheme.bodySmall! + Colors.white,
  titleLarge: _baseTextTheme.titleLarge! + Colors.white,
  titleMedium: _baseTextTheme.titleMedium! + Colors.white,
  titleSmall: _baseTextTheme.titleSmall! + Colors.white,
);
