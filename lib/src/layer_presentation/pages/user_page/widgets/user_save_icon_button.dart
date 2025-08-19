import 'package:flutter/material.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/save_icon_button.dart';

class UserSaveIconButton extends StatelessWidget {
  const UserSaveIconButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SaveIconButton(onPressed: onPressed);
  }
}
