import 'package:flutter/material.dart';
import 'package:genesis/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:genesis/src/widgets/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

part './routes.dart';

final appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.dashboard.name,
              path: '/',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: DashboardPage()
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.monitoring.name,
              path: '/monitoring',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    body: Center(child: Text('monitoring')),
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.users.name,
              path: '/users',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    body: Center(child: Text('user')),
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: AppRoutes.vpn.name,
              path: '/vpn',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    body: Center(child: Text('user')),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
