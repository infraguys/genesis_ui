import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get w700 => copyWith(fontWeight: .w700);

  TextStyle get w600 => copyWith(fontWeight: .w600);

  TextStyle get w500 => copyWith(fontWeight: .w500);

  TextStyle get w400 => copyWith(fontWeight: .w400);

  TextStyle get italic => copyWith(fontStyle: .italic);

  TextStyle get underline => copyWith(decoration: .underline);

  TextStyle size(double size) => copyWith(fontSize: size);

  TextStyle operator +(Color? color) => copyWith(color: color);
}
