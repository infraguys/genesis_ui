import 'package:flutter/material.dart';

abstract class FormControllersManager {
  /// Returns a list of all controllers.
  List<TextEditingController> get all;

  /// Returns true if all controllers have text.
  bool get allFilled;

  /// Clears the text in all text controllers.
  void clear() {
    for (final controller in all) {
      controller.clear();
    }
  }

  /// Disposes all controllers.
  void dispose() {
    for (final controller in all) {
      controller.dispose();
    }
  }
}
