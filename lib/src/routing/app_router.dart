import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organization_bloc/organization_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_selection_bloc/organizations_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_bloc/permissions_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/permissions_selection_bloc/permissions_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_selection_bloc/projects_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bloc/role_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_selection_bloc/roles_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_selection_bloc/users_selection_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/attach_project_page/attach_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/attach_roles_page/attach_roles_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_organization_page/create_organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_project_page/create_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/create_role_page/create_role_page.dart';
import 'package:genesis/src/layer_presentation/pages/main_page/main_page.dart';
import 'package:genesis/src/layer_presentation/pages/organization_page/organization_page.dart';
import 'package:genesis/src/layer_presentation/pages/organizations_page/organizations_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_page.dart';
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
                  child: BlocProvider(
                    create: (_) => UsersSelectionBloc(),
                    child: UsersPage(),
                  ),
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
                      child: UserPage(userUUID: state.pathParameters['uuid']!),
                    ),
                    routes: [
                      GoRoute(
                        name: AppRoutes.attachProject.name,
                        path: 'attach/project',
                        pageBuilder: (_, _) => NoTransitionPage(
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => RolesSelectionBloc(),
                              ),
                              BlocProvider(
                                create: (_) => ProjectsSelectionBloc(),
                              ),
                            ],
                            child: AttachProjectPage(),
                          ),
                        ),
                      ),
                      GoRoute(
                        name: AppRoutes.attachRoles.name,
                        path: 'attach/project/:projectUuid/attach_roles',
                        pageBuilder: (_, state) {
                          final projectUuid = state.pathParameters['projectUuid']!;
                          return NoTransitionPage(
                            child: MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) => RolesSelectionBloc(),
                                ),
                              ],
                              child: AttachRolesPage(projectUuid: projectUuid),
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
          StatefulShellBranch(
            navigatorKey: projectsNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.projects.name,
                path: '/projects',
                pageBuilder: (_, _) => NoTransitionPage(
                  child: BlocProvider(
                    create: (_) => ProjectsSelectionBloc(),
                    child: ProjectsPage(),
                  ),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createProject.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => OrganizationsSelectionBloc(),
                          ),
                          BlocProvider(
                            create: (_) => UsersSelectionBloc(),
                          ),
                          BlocProvider(
                            create: (_) => RolesSelectionBloc(),
                          ),
                        ],
                        child: CreateProjectPage(),
                      ),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.project.name,
                    path: ':uuid',
                    pageBuilder: (_, state) {
                      final _ = state.pathParameters['uuid']!;
                      final project = state.extra as Project;
                      return NoTransitionPage(
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (_) => OrganizationsSelectionBloc(),
                            ),
                            BlocProvider(
                              create: (_) => UsersSelectionBloc(),
                            ),
                            BlocProvider(
                              create: (_) => RolesSelectionBloc(),
                            ),
                          ],
                          child: ProjectPage(project: project),
                        ),
                      );
                    },
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
                  child: BlocProvider(
                    create: (_) => RolesSelectionBloc(),
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
                            create: (_) => RoleBloc(
                              rolesRepository: context.read<IRolesRepository>(),
                              permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
                            ),
                          ),
                        ],
                        child: CreateRolePage(),
                      ),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.role.name,
                    path: ':uuid',
                    pageBuilder: (_, state) {
                      final _ = state.pathParameters['uuid']!;
                      final role = state.extra as Role;
                      return NoTransitionPage(
                        child: MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => PermissionsBloc(context.read<IPermissionsRepository>()),
                            ),
                            BlocProvider(
                              create: (_) => PermissionsSelectionBloc(),
                            ),
                            BlocProvider(
                              create: (_) => RoleBloc(
                                rolesRepository: context.read<IRolesRepository>(),
                                permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
                              ),
                            ),
                          ],
                          child: RolePage(role: role),
                        ),
                      );
                    },
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
                    create: (_) => OrganizationsSelectionBloc(),
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
                    name: AppRoutes.organization.name,
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
