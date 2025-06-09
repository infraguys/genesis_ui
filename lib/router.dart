import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genesis_admin_dashboard_template/features/nodes/data.dart';
import 'package:genesis_admin_dashboard_template/features/users/user_not_found_page.dart';
import 'package:go_router/go_router.dart';

import 'features/dashboard/dashbord_page.dart';
import 'features/nodes/node_not_found_page.dart';
import 'features/nodes/node_page.dart';
import 'features/nodes/nodes_page.dart';
import 'features/users/user_page.dart';
import 'features/users/users_page.dart';
import 'features/vpns/vpns_page.dart';
import 'features/iam/models.dart';
import 'features/iam/user_data.dart';
import 'widgets/widgets.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
  navigatorKey: _rootNavigatorKey,
);

@TypedStatefulShellRoute<ShellRouteData>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DashboardRoute>(
          path: '/',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<UsersPageRoute>(
          path: '/users',
          routes: [
            TypedGoRoute<UserPageRoute>(
              path: ':userUuid',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<NodesPageRoute>(
          path: '/nodes',
          routes: [
            TypedGoRoute<NodePageRoute>(
              path: ':nodeUuid',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<VpnsPageRoute>(
          path: '/vpns',
          routes: [
            
          ],
        ),
      ],
    ),
  ],
)
class ShellRouteData extends StatefulShellRouteData {
  const ShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return SelectionArea(
      child: ScaffoldWithNavigation(
        navigationShell: navigationShell,
      ),
    );
  }
}

class DashboardRoute extends GoRouteData {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DashBoardPage();
  }
}

// Users

class UsersPageRoute extends GoRouteData {
  const UsersPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const UsersPage();
  }
}

class UserPageRoute extends GoRouteData {
  const UserPageRoute({required this.userUuid});

  final String userUuid;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final user = genesisUsers.firstWhereOrNull((e) => e.uuid == userUuid);
    return user == null
        ? UserNotFoundPage(userUuid: userUuid)
        : UserPage(user: user);
  }
}

// Nodes

class NodesPageRoute extends GoRouteData {
  const NodesPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NodesPage();
  }
}

class NodePageRoute extends GoRouteData {
  const NodePageRoute({required this.nodeUuid});

  final String nodeUuid;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final node = genesisCoreNodes.firstWhereOrNull((e) => e.uuid == nodeUuid);
    return node == null
        ? NodeNotFoundPage(nodeUuid: nodeUuid)
        : NodePage(node: node);
  }
}

// VPN

class VpnsPageRoute extends GoRouteData {
  const VpnsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const VpnsPage();
  }
}
