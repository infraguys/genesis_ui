import 'package:flutter/material.dart';
import 'package:genesis/src/extensions/localized_build_context.dart';
import 'package:genesis/src/extensions/string_extension.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<void>(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Sign out'),
                onTap: () {
                  // Sign out logic
                },
              ),
            ],
            child: const Icon(Icons.notifications_none_outlined),
          ),
          const SizedBox(width: 24),
          PopupMenuButton<void>(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Sign out'),
                onTap: () {
                  // Sign out logic
                },
              ),
            ],
            child: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      drawer: NavigationDrawer(
        tilePadding: EdgeInsetsGeometry.zero,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: goBranch,
        children: [
          NavigationDrawerDestination(icon: Icon(Icons.dashboard), label: Text(context.$.dashboard)),
          NavigationDrawerDestination(icon: Icon(Icons.laptop), label: Text('Monitoring'.hardcoded)),
        ],
      ),
      body: navigationShell,
    );
  }
}
