import 'package:flutter/material.dart';

// part './light_text_theme.dart';
//
// part './dark_text_theme.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade200,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        actionsPadding: EdgeInsets.only(right: 16),
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: Colors.grey.shade50.withValues(alpha: .99),
        indicatorShape: RoundedRectangleBorder(),
        indicatorColor: Colors.transparent,
        iconTheme: WidgetStateProperty.fromMap({
          WidgetState.selected: IconThemeData(color: Colors.blue),
          WidgetState.any: IconThemeData(color: Colors.grey),
        }),
        labelTextStyle: WidgetStateTextStyle.fromMap({
          WidgetState.selected: TextStyle(color: Colors.blue),
          WidgetState.any: TextStyle(color: Colors.grey),
        }),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
      cardTheme: CardThemeData(color: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        outlineBorder: BorderSide(
          color: Color(0xFF3C3E3F),
        ),
      ),
    );
  }

  // Dark theme
  //   ThemeData get dark {
  //     return ThemeData(
  //       textTheme: _darkTextTheme,
  //     );
  //   }
}
