import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';

part 'appbar_theme_data.dart';
part 'elevated_button_theme_data.dart';
part 'input_decoration_theme.dart';
part 'navigation_drawer_theme_data.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.grey.shade200,
      appBarTheme: _appbarThemeData,
      navigationDrawerTheme: _navigationDrawerThemeData,
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
      cardTheme: CardThemeData(color: Colors.white),
      inputDecorationTheme: _inputDecorationThemeData,
      elevatedButtonTheme: _elevatedButtonThemeData,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
      expansionTileTheme: ExpansionTileThemeData(
        childrenPadding: EdgeInsets.only(left: 12),
        shape: OutlineInputBorder(borderSide: BorderSide.none),
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
