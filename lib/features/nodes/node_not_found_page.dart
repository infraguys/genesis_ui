import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NodeNotFoundPage extends StatelessWidget {
  const NodeNotFoundPage({super.key, required this.nodeUuid});

  final String nodeUuid;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toFilePath();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Page not found: $location',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(8),
            Text('[$nodeUuid] is not found'),
          ],
        ),
      ),
    );
  }
}
