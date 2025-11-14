import 'package:flutter/material.dart';
import 'package:genesis/src/shared/presentation/ui/tokens/palette.dart';

class AddProjectCard extends StatelessWidget {
  const AddProjectCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        clipBehavior: .hardEdge,
        color: Palette.color333333,
        child: InkWell(
          onTap: onTap,
          child: Center(child: Icon(Icons.add, color: Palette.color6DCF91, size: 32)),
        ),
      ),
    );
  }
}
