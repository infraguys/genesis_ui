import 'package:flutter/material.dart';

abstract interface class BaseStatusEnum {
  String humanReadable(BuildContext context);

  abstract Color color;

  abstract Color labelColor;
}
