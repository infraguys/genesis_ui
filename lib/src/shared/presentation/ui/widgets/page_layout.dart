import 'package:flutter/material.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    required this.breadcrumbs,
    required this.buttons,
    required this.child,
    super.key,
  });

  final List<BreadcrumbItem> breadcrumbs;
  final List<Widget> buttons;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Breadcrumbs(items: breadcrumbs),
        ButtonsBar(children: buttons),
        SizedBox(height: 16.0),
        Expanded(child: child),
      ],
    );
  }
}
