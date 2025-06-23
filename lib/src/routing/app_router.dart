import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/auth/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:genesis/src/features/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:genesis/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:genesis/src/shared/widgets/page_not_found.dart';
import 'package:genesis/src/shared/widgets/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

part './routes.dart';

GoRouter createRouter(BuildContext context) {
  print('router');
  final authBloc = context.read<AuthBloc>();
  return GoRouter(
    initialLocation: '/sign_in',
    refreshListenable: _GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final bloc = context.read<AuthBloc>();
      if (bloc.state is Authenticated) {
        return '/';
      }

      if (bloc.state is Unauthenticated) {
        return '/sign_in';
      }
      return null;
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
                  return NoTransitionPage(child: DashboardPage());
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
    errorPageBuilder: (_, _) => NoTransitionPage(child: const PageNotFound()),
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
