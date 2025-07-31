import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Breadcrumbs extends StatelessWidget {
  const Breadcrumbs({super.key});

  @override
  Widget build(BuildContext context) {
    final fullPath = GoRouterState.of(context).fullPath!;

    final extra = GoRouterState.of(context).extra as ({Object? extra, List<String> breadcrumbs})?;
    final breadcrumbs = extra?.breadcrumbs;

    final segments = fullPath.split('/').where((segment) => segment.isNotEmpty).toList();

    if (breadcrumbs != null) {
      outerLoop:
      for (var it in breadcrumbs) {
        var innerIndex = 0;
        for (var i = innerIndex; i < segments.length; i += 1) {
          if (segments[i].startsWith(':')) {
            segments[i] = it;
            innerIndex = i + 1;
            continue outerLoop;
          }
        }
      }
    }

    final result = segments.join(' > ');
    return Text(result, style: TextStyle(color: Colors.white54, fontSize: 12));
  }
}
