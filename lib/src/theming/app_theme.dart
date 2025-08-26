import 'package:flutter/material.dart';
import 'package:genesis/src/core/extensions/color_extension.dart';
import 'package:genesis/src/core/extensions/text_style_extension.dart';
import 'package:genesis/src/theming/palette.dart';

part 'appbar_theme_data.dart';
part 'drawer_theme_data.dart';
part 'elevated_button_theme_data.dart';
part 'input_decoration_theme.dart';
part 'navigation_drawer_theme_data.dart';
part 'text_theme.dart';

class AppTheme {
  ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      textTheme: _lightTextTheme,
      scaffoldBackgroundColor: Palette.color1B1B1D,
      appBarTheme: _appbarThemeData,
      navigationDrawerTheme: _navigationDrawerThemeData,
      drawerTheme: _drawerThemeData,
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
      dividerTheme: DividerThemeData(
        thickness: 0.5,
        color: Palette.color333333,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Palette.color7C7774),
          borderRadius: BorderRadius.circular(4.0),
        ),
        checkColor: WidgetStateColor.fromMap({
          WidgetState.selected: Palette.color1B1B1D,
          WidgetState.any: Colors.transparent,
        }),
        fillColor: WidgetStateColor.fromMap({
          WidgetState.selected: Palette.colorFF8900,
          WidgetState.any: Colors.transparent,
        }),
      ),
    );
  }

  ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      textTheme: _darkTextTheme,
      scaffoldBackgroundColor: Palette.color1B1B1D,
      appBarTheme: _appbarThemeData,
      navigationDrawerTheme: _navigationDrawerThemeData,
      drawerTheme: _drawerThemeData,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Palette.color1B1B1D,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      dividerTheme: DividerThemeData(
        thickness: 0.5,
        color: Palette.color333333,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Palette.color7C7774),
          borderRadius: BorderRadius.circular(4.0),
        ),
        checkColor: WidgetStateColor.fromMap({
          WidgetState.selected: Palette.color1B1B1D,
          WidgetState.any: Colors.transparent,
        }),
        fillColor: WidgetStateColor.fromMap({
          WidgetState.selected: Palette.colorFF8900,
          WidgetState.any: Colors.transparent,
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(width: 0.1),
        ),
        color: WidgetStatePropertyAll(Palette.color252D29),
        iconTheme: IconThemeData(color: Colors.white),
        labelStyle: TextStyle(
          color: Palette.color6DCF91,
          fontSize: 14,
          height: 16 / 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
