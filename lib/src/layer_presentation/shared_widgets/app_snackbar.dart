import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar.success(String message, {super.key})
    : super(
        backgroundColor: Colors.green,
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      );

  AppSnackBar.failure(String message, {super.key})
    : super(
        backgroundColor: Colors.red,
        content: Text(message),
        duration: const Duration(milliseconds: 2000),
      );
}
