import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/theming/palette.dart';

part 'appbar_theme_data.dart';
part 'elevated_button_theme_data.dart';
part 'input_decoration_theme.dart';
part 'navigation_drawer_theme_data.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Palette.color1B1B1D,
      appBarTheme: _appbarThemeData,
      navigationDrawerTheme: _navigationDrawerThemeData,
      drawerTheme: DrawerThemeData(
        width: 220,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      cardTheme: CardThemeData(color: Colors.white),
      inputDecorationTheme: _inputDecorationThemeData,
      elevatedButtonTheme: _elevatedButtonThemeData,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
      listTileTheme: ListTileThemeData(
        textColor: Colors.white,
        iconColor: Palette.colorAFA8A4,
        tileColor: Colors.white.withValues(alpha: 0.05),
        selectedColor: Palette.colorFF8900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        textColor: Colors.white,
        collapsedTextColor: Colors.white,
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
