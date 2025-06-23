import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';

// part './light_text_theme.dart';
//
// part './dark_text_theme.dart';

part './input_decoration_theme.dart';

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
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
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
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white
        )
    );
  }

  // Dark theme
  //   ThemeData get dark {
  //     return ThemeData(
  //       textTheme: _darkTextTheme,
  //     );
  //   }
}
