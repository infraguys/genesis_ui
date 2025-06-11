import 'package:flutter/material.dart';
import 'package:genesis/src/extensions/string_extension.dart';
import 'package:genesis/src/widgets/custom_navigation_rail.dart';
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
    final textTheme = TextTheme.of(context);
    return Scaffold(
      body: Row(
        children: [
          CustomNavigationRail(
            extended: true,
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Text(
                    'Genesis',
                    style: textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: goBranch,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'.hardcoded),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.laptop),
                label: Text('Monitoring'.hardcoded),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Users'.hardcoded),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.vpn_key),
                label: Text('Vpn'.hardcoded),
              ),
            ],
          ),
          VerticalDivider(
            color: Colors.grey.shade300,
            thickness: 1,
            width: 1,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}
