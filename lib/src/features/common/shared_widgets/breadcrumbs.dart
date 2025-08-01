import 'dart:core';

import 'package:flutter/material.dart';

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({required this.items, super.key});

  final List<BreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 6.0,
      children: items
          .map(
            (it) => GestureDetector(
              onTap: it.onTap,
              child: Text(it.text, style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          )
          .intersperse(Text('›', style: TextStyle(color: Colors.white54, fontSize: 12)))
          .toList(),
    );
  }
}

final class BreadcrumbItem {
  BreadcrumbItem({
    required this.text,
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;
}

extension _ on Iterable<Widget> {
  Iterable<Widget> intersperse(Widget separator) sync* {
    final it = iterator;
    if (!it.moveNext()) return;
    yield it.current;
    while (it.moveNext()) {
      yield separator;
      yield it.current;
    }
  }
}
