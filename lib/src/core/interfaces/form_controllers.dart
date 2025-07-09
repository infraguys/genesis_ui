import 'package:flutter/material.dart';

abstract class FormControllersManager {
  /// Returns a list of all controllers.
  List<TextEditingController> get all;

  /// Returns true if all controllers have text.
  bool get allFilled;

  /// Disposes all controllers.
  void dispose() {
    for (final controller in all) {
      controller.dispose();
    }
  }
}
