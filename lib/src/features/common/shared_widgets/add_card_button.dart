import 'package:flutter/material.dart';

class AddCardButton extends StatelessWidget {
  const AddCardButton({
    required this.child,
    super.key,
    this.iconData = Icons.add,
  });

  final Widget child;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => child,
            );
          },
          child: Center(child: Icon(iconData)),
        ),
      ),
    );
  }
}
