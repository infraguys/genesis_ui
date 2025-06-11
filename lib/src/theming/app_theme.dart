import 'package:flutter/material.dart';

// part './light_text_theme.dart';
//
// part './dark_text_theme.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade200,
      navigationRailTheme: NavigationRailThemeData(
        useIndicator: false,
        selectedIconTheme: IconThemeData(color: Colors.blue),
        selectedLabelTextStyle: TextStyle(color: Colors.blue),
        minExtendedWidth: 170,
        backgroundColor: Colors.grey.shade50.withValues(alpha: .99),
      ),
      cardTheme: CardThemeData(
        color: Colors.grey.shade50.withValues(alpha: .99)
      )
      // textTheme: _lightTextTheme,
    );
  }

  // Dark theme
  //   ThemeData get dark {
  //     return ThemeData(
  //       textTheme: _darkTextTheme,
  //     );
  //   }
}
