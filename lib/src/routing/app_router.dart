import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/auth/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:genesis/src/features/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:genesis/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:genesis/src/features/projects/presentation/projects_page.dart';
import 'package:genesis/src/features/roles/presentation/roles_page.dart';
import 'package:genesis/src/features/users/presentation/users_page.dart';
import 'package:genesis/src/features/users/presentation/widgets/user_page.dart';
import 'package:genesis/src/shared/widgets/page_not_found.dart';
import 'package:genesis/src/shared/widgets/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

part './routes.dart';

final _authRoutes = [
  '/sign_in',
  '/sign_up',
];

GoRouter createRouter(BuildContext context) {
  print('router');
  final authBloc = context.read<AuthBloc>();
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _GoRouterRefreshStream(authBloc.stream),
    errorPageBuilder: (_, _) => NoTransitionPage(child: const PageNotFound()),
    redirect: (context, state) {
      final bloc = context.read<AuthBloc>();
      final isAuthRoute = _authRoutes.contains(state.matchedLocation);

      return switch (bloc.state) {
        Authenticated() when isAuthRoute => '/',
        Unauthenticated() when !isAuthRoute => '/sign_in',
        _ => null,
      };
    },
    routes: [
      GoRoute(
        name: AppRoutes.signIn.name,
        path: '/sign_in',
        pageBuilder: (_, _) => NoTransitionPage(child: SignInScreen()),
      ),
      GoRoute(
        name: AppRoutes.signUp.name,
        path: '/sign_up',
        pageBuilder: (_, _) => NoTransitionPage(child: SignUpScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) {
          return ScaffoldWithNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.dashboard.name,
                path: '/',
                pageBuilder: (_, _) {
                  return NoTransitionPage(child: DashboardPage());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.users.name,
                path: '/users',
                pageBuilder: (context, _) {
                  return NoTransitionPage(child: UsersPage());
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.user.name,
                    path: ':uuid',
                    pageBuilder: (_, state) {
                      final userId = state.pathParameters['uuid']!;
                      return NoTransitionPage(
                        child: UserPage(userId: userId),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.projects.name,
                path: '/projects',
                pageBuilder: (_, _) {
                  return NoTransitionPage(child: ProjectsPage());
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.roles.name,
                path: '/roles',
                pageBuilder: (_, _) {
                  return NoTransitionPage(child: RolesPage());
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.listen((state) {
      notifyListeners();
    });
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
