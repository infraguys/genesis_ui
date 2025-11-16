import 'package:flutter/material.dart';

class GeneralDialogLayout extends StatelessWidget {
  const GeneralDialogLayout({
    required this.child,
    this.constraints = const BoxConstraints(maxWidth: 900),
    super.key,
  });

  final Widget child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Padding(
        padding: .all(16.0),
        child: child,
      ),
    );
  }
}
