import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);

  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);

  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);

  TextStyle get w400 => copyWith(fontWeight: FontWeight.normal);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle operator +(Color? color) => copyWith(color: color);
}
