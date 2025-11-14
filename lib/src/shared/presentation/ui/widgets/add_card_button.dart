import 'package:flutter/material.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({
    super.key,
    this.onTap,
    this.iconData = Icons.add,
  });

  final IconData? iconData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        clipBehavior: .hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Center(child: Icon(iconData, size: 32)),
        ),
      ),
    );
  }
}
