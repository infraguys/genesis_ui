import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/auth/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:genesis/src/features/auth/presentation/sign_up_screen/sign_up_screen.dart';
import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/common/shared_widgets/page_not_found.dart';
import 'package:genesis/src/features/common/shared_widgets/scaffold_with_navigation.dart';
import 'package:genesis/src/features/dashboard/presentation/dashboard_page.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/presentation/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/features/projects/presentation/projects_page.dart';
import 'package:genesis/src/features/role/presentation/roles_page.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/presentation/blocs/create_user_bloc/create_user_bloc.dart';
import 'package:genesis/src/features/users/presentation/user_page.dart';
import 'package:genesis/src/features/users/presentation/users_page.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

final _authRoutes = [
  '/sign_in',
  '/sign_up',
];

GoRouter createRouter(BuildContext context) {
  print('router');
  final authBloc = context.read<AuthBloc>();

  final rootNavKey = GlobalKey<NavigatorState>();
  final dashboardNavKey = GlobalKey<NavigatorState>();
  final usersNavKey = GlobalKey<NavigatorState>();
  final projectsNavKey = GlobalKey<NavigatorState>();
  final rolesNavKey = GlobalKey<NavigatorState>();

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: _GoRouterRefreshStream(authBloc.stream),
    errorPageBuilder: (_, _) => NoTransitionPage(child: const PageNotFound()),
    navigatorKey: rootNavKey,
    redirect: (context, state) {
      final bloc = context.read<AuthBloc>();
      final isAuthRoute = _authRoutes.contains(state.matchedLocation);

      return switch (bloc.state) {
        AuthenticatedAuthState() when isAuthRoute => '/',
        UnauthenticatedAuthState() when !isAuthRoute => '/sign_in',
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
        pageBuilder: (_, _) {
          return NoTransitionPage(
            child: BlocProvider(
              create: (context) => CreateUserBloc(context.read<IUsersRepository>()),
              child: SignUpScreen(),
            ),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) {
          return ScaffoldWithNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: dashboardNavKey,
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
            navigatorKey: usersNavKey,
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
                      final _ = state.pathParameters['uuid']!;
                      return NoTransitionPage(
                        child: BlocProvider(
                          create: (context) {
                            final repository = context.read<IProjectsRepository>();
                            return UserProjectsBloc(repository);
                          },
                          child: UserPage(user: state.extra as User),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: projectsNavKey,
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
            navigatorKey: rolesNavKey,
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
