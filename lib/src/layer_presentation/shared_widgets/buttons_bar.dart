import 'package:flutter/material.dart';

class ButtonsBar extends StatelessWidget {
  const ButtonsBar({required this.children, super.key}) : _isLeftSpacer = true;

  const ButtonsBar.withoutLeftSpacer({required this.children, super.key}) : _isLeftSpacer = false;

  final List<Widget> children;
  final bool _isLeftSpacer;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        if (_isLeftSpacer) Spacer(),
        ...children,
      ],
    );
  }
}
