import 'package:flutter/material.dart';

class GeneralDialogLayout extends StatelessWidget {
  const GeneralDialogLayout({
    required this.child,
    required this.constraints,
    super.key,
  });

  final Widget child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: child,
      ),
    );
  }
}
