import 'package:flutter/material.dart';

class ButtonsBar extends StatelessWidget {
  const ButtonsBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.0,
      children: [
        Spacer(),
        ...children,
      ],
    );
  }
}
