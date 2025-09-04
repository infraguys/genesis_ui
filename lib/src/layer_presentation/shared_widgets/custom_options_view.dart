import 'package:flutter/material.dart';

class CustomOptionsView extends StatelessWidget {
  const CustomOptionsView({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        color: Colors.grey[850],
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: child,
      ),
    );
  }
}
