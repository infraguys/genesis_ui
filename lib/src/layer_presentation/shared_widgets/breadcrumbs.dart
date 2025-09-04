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
              child: Text(it.text.toLowerCase(), style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
          )
          .wrapWithHoverable()
          .intersperse(Text('›', style: TextStyle(color: Colors.white54, fontSize: 12)))
          .toList(),
    );
  }
}

final class BreadcrumbItem {
  BreadcrumbItem({
    required this.text,
    this.onTap,
    // this.clickable = true,
  });

  final String text;
  final VoidCallback? onTap;
  // final bool clickable;
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

  Iterable<Widget> wrapWithHoverable() sync* {
    for (var i = 0; i < length; i++) {
      final isLast = i == length - 1;
      yield MouseRegion(
        cursor: isLast ? MouseCursor.defer : SystemMouseCursors.click,
        child: elementAt(i),
      );
    }
  }
}
