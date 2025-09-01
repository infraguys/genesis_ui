import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/attach_project_page/attach_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/attach_roles_page/attach_roles_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_organization_page/create_organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_project_page/create_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_role_page/create_role_page.dart';
import 'package:genesis/src/layer_presentation/pages/main_page/main_page.dart';
import 'package:genesis/src/layer_presentation/pages/organization_page/organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/organizations_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_page/project_page.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/projects_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/role_page.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/roles_page.dart';
import 'package:genesis/src/layer_presentation/pages/sign_in_page/sign_in_screen.dart';
import 'package:genesis/src/layer_presentation/pages/sign_up_page/sign_up_screen.dart';
import 'package:genesis/src/layer_presentation/pages/users/create_user_page/create_user_page.dart';
import 'package:genesis/src/layer_presentation/pages/users/user_page/user_page.dart';
import 'package:genesis/src/layer_presentation/pages/users/users_page/users_page.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/page_not_found.dart';
import 'package:genesis/src/layer_presentation/shared_widgets/scaffold_with_navigation.dart';
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
  final mainNavKey = GlobalKey<NavigatorState>();
  final usersNavKey = GlobalKey<NavigatorState>();
  final projectsNavKey = GlobalKey<NavigatorState>();
  final rolesNavKey = GlobalKey<NavigatorState>();
  final organizationsNavKey = GlobalKey<NavigatorState>();

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
            child: SignUpScreen(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (_, _, navigationShell) {
          return NoTransitionPage(child: ScaffoldWithNavigation(navigationShell: navigationShell));
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: mainNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.main.name,
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
                pageBuilder: (_, _) => NoTransitionPage(
                  child: UsersPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createUser.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: CreateUserPage(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.user.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: UserPage(userUUID: UserUUID(state.pathParameters['uuid']!)),
                    ),
                    routes: [
                      GoRoute(
                        name: AppRoutes.attachProject.name,
                        path: 'attach/project',
                        pageBuilder: (_, _) => NoTransitionPage(
                          child: AttachProjectPage(),
                        ),
                      ),
                      GoRoute(
                        name: AppRoutes.attachRoles.name,
                        path: 'attach/project/:projectUuid/attach_roles',
                        pageBuilder: (_, state) => NoTransitionPage(
                          child: AttachRolesPage(projectUUID: ProjectUUID(state.pathParameters['projectUuid']!)),
                        ),
                      ),
                    ],
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
                pageBuilder: (_, _) => NoTransitionPage(
                  child: ProjectsPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createProject.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: CreateProjectPage(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.project.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: ProjectPage(uuid: state.pathParameters['uuid']!),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: rolesNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.roles.name,
                path: '/roles',
                pageBuilder: (_, _) => NoTransitionPage(
                  child: RolesPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createRole.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: CreateRolePage(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.role.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: RolePage(role: state.extra as Role),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: organizationsNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.organizations.name,
                path: '/organizations',
                pageBuilder: (_, _) => NoTransitionPage(
                  child: OrganizationsPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createOrganization.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: CreateOrganizationPage(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.organization.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: OrganizationPage(organization: state.extra as Organization),
                    ),
                  ),
                ],
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
