import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/pages/create_organization_page/create_organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/main_page/main_page.dart';
import 'package:genesis/src/layer_presentation/pages/organization_page/organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/organizations_page.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/projects_page/projects_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/blocs/permissions_selection_bloc/permissions_selection_bloc%20.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/blocs/role_editor_bloc/role_editor_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/role_page/role_page.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/roles_page/roles_page.dart';
import 'package:genesis/src/layer_presentation/pages/sign_in_page/sign_in_screen.dart';
import 'package:genesis/src/layer_presentation/pages/sign_up_page/blocs/create_user_bloc/create_user_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/sign_up_page/sign_up_screen.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/blocs/user_projects_bloc/user_projects_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/user_page/user_page.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/users_page/users_page.dart';
import 'package:genesis/src/layer_presentation/shared_blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/shared_blocs/organization_editor_bloc/organization_bloc.dart';
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
            child: BlocProvider(
              create: (context) => CreateUserBloc(context.read<IUsersRepository>()),
              child: SignUpScreen(),
            ),
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
                  child: BlocProvider(
                    create: (context) => UsersSelectionBloc(),
                    child: UsersPage(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.user.name,
                    path: ':uuid',
                    pageBuilder: (_, state) {
                      final _ = state.pathParameters['uuid']!;
                      final user = state.extra as User;
                      return NoTransitionPage(
                        child: BlocProvider(
                          create: (context) {
                            return UserProjectsBloc(context.read<IProjectsRepository>());
                          },
                          child: UserPage(user: user),
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
                pageBuilder: (_, _) => NoTransitionPage(
                  child: BlocProvider(
                    create: (context) => ProjectsSelectionBloc(),
                    child: ProjectsPage(),
                  ),
                ),
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
                  child: BlocProvider(
                    create: (context) => RolesSelectionBloc(),
                    child: RolesPage(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createRole.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => PermissionsBloc(context.read<IPermissionsRepository>()),
                          ),
                          BlocProvider(
                            create: (_) => PermissionsSelectionBloc(),
                          ),
                          BlocProvider(
                            create: (_) => RoleEditorBloc(context.read<IRolesRepository>()),
                          ),
                        ],
                        child: RolePage(),
                      ),
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
                  child: BlocProvider(
                    create: (context) => OrganizationsSelectionBloc(),
                    child: OrganizationsPage(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createOrganization.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => OrganizationBloc(context.read<IOrganizationsRepository>()),
                          ),
                        ],
                        child: CreateOrganizationPage(),
                      ),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.editOrganization.name,
                    path: ':uuid',
                    pageBuilder: (_, state) {
                      final _ = state.pathParameters['uuid']!;
                      final organization = state.extra as Organization;
                      return NoTransitionPage(
                        child: BlocProvider(
                          create: (context) => OrganizationBloc(context.read<IOrganizationsRepository>()),
                          child: OrganizationPage(organization: organization),
                        ),
                      );
                    },
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
