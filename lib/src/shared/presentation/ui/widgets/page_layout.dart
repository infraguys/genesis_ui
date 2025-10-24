import 'package:flutter/material.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/breadcrumbs.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/buttons_bar.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    required this.breadcrumbs,
    required this.buttonsBar,
    required this.children,
    super.key,
  });

  final Breadcrumbs breadcrumbs;
  final ButtonsBar buttonsBar;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          breadcrumbs,
          Column(
            spacing: 16.0,
            children: [
              buttonsBar,
              ...children,
            ],
          ),
        ],
      ),
    );
  }
}
