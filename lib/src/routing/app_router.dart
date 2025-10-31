import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/dbaas/domain/entities/cluster.dart';
import 'package:genesis/src/features/dbaas/domain/entities/database.dart';
import 'package:genesis/src/features/dbaas/domain/entities/pg_user.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/cluster_page/cluster_page.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/database_page/database_page.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_instance_list_page/cluster_list_page.dart';
import 'package:genesis/src/features/dbaas/presentation/pages/pg_user_page/pg_user_page.dart';
import 'package:genesis/src/features/extensions/presentation/pages/extension_list_page/extension_list_page.dart';
import 'package:genesis/src/features/extensions/presentation/pages/main_page/main_page.dart';
import 'package:genesis/src/features/nodes/domain/entities/node.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/features/nodes/presentation/pages/node_list_page/node_list_page.dart';
import 'package:genesis/src/features/nodes/presentation/pages/node_page/node_page.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/projects/domain/entities/project.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/presentation/dialogs/create_user_dialog/create_user_dialog.dart';
import 'package:genesis/src/features/users/presentation/pages/user_list_page/user_list_page.dart';
import 'package:genesis/src/features/users/presentation/pages/user_page/user_page.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/auth_pages/sign_in_page/sign_in_screen.dart';
import 'package:genesis/src/layer_presentation/pages/auth_pages/sign_up_page/sign_up_screen.dart';
import 'package:genesis/src/layer_presentation/pages/organization_pages/organization_details_page/organization_details_page.dart';
import 'package:genesis/src/layer_presentation/pages/organization_pages/organization_list_page/organization_list_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_pages/attach_project_page/attach_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_pages/create_project_page/create_project_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_pages/project_details_page/project_details_page.dart';
import 'package:genesis/src/layer_presentation/pages/project_pages/project_list_page/project_list_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/attach_roles_page/attach_roles_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/create_role_page/create_role_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_details_page/role_details_page.dart';
import 'package:genesis/src/layer_presentation/pages/role_pages/role_list_page/role_list_page.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/domain_setup_page.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/layer_presentation/pages/splash_screen/splash_screen.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/page_not_found.dart';
import 'package:genesis/src/shared/presentation/ui/widgets/scaffold_with_navigation.dart';
import 'package:go_router/go_router.dart';

part 'routes.dart';

final RouteObserver<PageRoute<dynamic>> clustersObserver = RouteObserver<PageRoute<dynamic>>();
final RouteObserver<PageRoute<dynamic>> clusterObserver = RouteObserver<PageRoute<dynamic>>();

GoRouter createRouter(BuildContext context) {
  print('router');
  final rootNavKey = GlobalKey<NavigatorState>();
  final mainNavKey = GlobalKey<NavigatorState>();
  final usersNavKey = GlobalKey<NavigatorState>();
  final projectsNavKey = GlobalKey<NavigatorState>();
  final rolesNavKey = GlobalKey<NavigatorState>();
  final organizationsNavKey = GlobalKey<NavigatorState>();
  final nodesNavKey = GlobalKey<NavigatorState>();
  final extensionsNavKey = GlobalKey<NavigatorState>();
  final dbaasNavKey = GlobalKey<NavigatorState>();

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/splash',
    refreshListenable: Listenable.merge(
      [
        _GoRouterAuthListenable(context),
        _GoRouterConfigListenable(context),
      ],
    ),
    errorPageBuilder: (_, _) => NoTransitionPage(child: const PageNotFound()),
    navigatorKey: rootNavKey,
    redirect: (context, state) {
      final GoRouterState(:matchedLocation) = state;

      final authState = context.read<AuthBloc>().state;
      final domainCubitState = context.read<DomainSetupCubit>().state;

      if (domainCubitState is DomainSetupInitialState) {
        return '/splash';
      }

      /// Если domain ещё не установлен -> на страницу ввода
      if (domainCubitState is DomainSetupEmptyState) {
        return '/domain_setup';
      }

      switch (authState) {
        case AuthStateLoading():
          return '/splash';
        case AuthenticatedAuthState() when matchedLocation == '/sign_in':
        case AuthenticatedAuthState() when matchedLocation == '/sign_up':
        case AuthenticatedAuthState() when matchedLocation == '/splash':
        case AuthenticatedAuthState() when matchedLocation == '/domain_setup':
          return '/';
        case UnauthenticatedAuthState() when matchedLocation != '/sign_in':
        case UnauthenticatedAuthState() when matchedLocation != '/sign_up':
          return '/sign_in';
        default:
          return null;
      }
    },
    routes: [
      GoRoute(
        name: AppRoutes.splash.name,
        path: '/splash',
        pageBuilder: (_, _) => NoTransitionPage(child: const SplashScreen()),
      ),
      GoRoute(
        name: AppRoutes.domainSetup.name,
        path: '/domain_setup',
        pageBuilder: (_, _) => NoTransitionPage(child: const DomainSetupPage()),
      ),
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
        pageBuilder: (context, _, navigationShell) {
          return NoTransitionPage(child: ScaffoldWithNavigation(navigationShell: navigationShell));
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: mainNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.main.name,
                path: '/',
                pageBuilder: (context, _) {
                  return NoTransitionPage(child: MainPage());
                },
                onExit: (context, _) {
                  context.read<ClustersBloc>().add(ClustersEvent.stopPolling());
                  return true;
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
                  child: UserListPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.createUser.name,
                    path: 'create',
                    pageBuilder: (_, _) => NoTransitionPage(
                      child: CreateUserDialog(),
                    ),
                  ),
                  GoRoute(
                    name: AppRoutes.user.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: UserDetailsPage(userID: UserID(state.pathParameters['uuid']!)),
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
                          child: AttachRolesPage(projectUUID: ProjectID(state.pathParameters['projectUuid']!)),
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
                  child: ProjectListPage(),
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
                      child: ProjectDetailsPage(uuid: ProjectID(state.pathParameters['uuid']!)),
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
                  child: RoleListPage(),
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
                      child: RoleDetailsPage(uuid: RoleUUID(state.pathParameters['uuid']!)),
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
                  child: OrganizationListPage(),
                ),
                routes: [
                  // GoRoute(
                  //   name: AppRoutes.createOrganization.name,
                  //   path: 'create',
                  //   pageBuilder: (_, _) => NoTransitionPage(
                  //     child: CreateOrganizationPage(),
                  //   ),
                  // ),
                  GoRoute(
                    name: AppRoutes.organization.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: OrganizationDetailsPage(id: OrganizationID(state.pathParameters['uuid']!)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: nodesNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.nodes.name,
                path: '/nodes',
                onExit: (context, state) {
                  context.read<NodesBloc>().add(NodesEvent.stopPolling());
                  return true;
                },
                pageBuilder: (_, _) => NoTransitionPage(
                  child: NodeListPage(),
                ),
                routes: [
                  // GoRoute(
                  //   name: AppRoutes.createNode.name,
                  //   path: 'create',
                  //   pageBuilder: (_, _) => throw UnimplementedError(),
                  // ),
                  GoRoute(
                    name: AppRoutes.node.name,
                    path: ':uuid',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: NodePage(id: NodeID(state.pathParameters['uuid']!)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: dbaasNavKey,
            observers: [clustersObserver, clusterObserver],
            routes: [
              GoRoute(
                // TODO(Koretsky): возможно придется переименовать
                onExit: (context, state) {
                  context.read<ClustersBloc>().add(ClustersEvent.stopPolling());
                  return true;
                },
                name: AppRoutes.clusters.name,
                path: '/clusters',
                pageBuilder: (_, _) => NoTransitionPage(
                  child: ClustersListPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.cluster.name,
                    path: ':cluster_id',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: ClusterPage(clusterId: ClusterID(state.pathParameters['cluster_id']!)),
                    ),
                    routes: [
                      GoRoute(
                        name: AppRoutes.pgUser.name,
                        path: 'users/:user_id',
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: PgUserPage(
                            clusterId: ClusterID(GoRouter.of(context).state.pathParameters['cluster_id']!),
                            pgUserId: PgUserID(state.pathParameters['user_id']!),
                          ),
                        ),
                      ),
                      GoRoute(
                        name: AppRoutes.pgDb.name,
                        path: 'databases/:db_id',
                        pageBuilder: (context, state) => NoTransitionPage(
                          child: DatabasePage(
                            pgInstanceId: ClusterID(GoRouter.of(context).state.pathParameters['cluster_id']!),
                            databaseId: DatabaseID(state.pathParameters['db_id']!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: extensionsNavKey,
            routes: [
              GoRoute(
                name: AppRoutes.allExtensions.name,
                path: '/extensions',
                pageBuilder: (_, _) => NoTransitionPage(
                  child: ExtensionListPage(),
                ),
                routes: [
                  GoRoute(
                    name: AppRoutes.installedExtensions.name,
                    path: 'installed',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: Placeholder(),
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

class _GoRouterAuthListenable extends ChangeNotifier {
  _GoRouterAuthListenable(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    notifyListeners();
    _subscription = bloc.stream
        .distinct((prev, next) => prev.runtimeType == next.runtimeType)
        .listen((state) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class _GoRouterConfigListenable extends ChangeNotifier {
  _GoRouterConfigListenable(BuildContext context) {
    final cubit = context.read<DomainSetupCubit>();
    _subscription = cubit.stream
        .where((evt) => evt is DomainSetupReadState || evt is DomainSetupEmptyState || evt is DomainSetupWrittenState)
        .distinct((prev, next) => prev.runtimeType == next.runtimeType)
        .listen((state) => notifyListeners());
  }

  late final StreamSubscription<DomainSetupState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class DialogPage extends CustomTransitionPage<void> {
  DialogPage({required WidgetBuilder builder})
    : super(
        child: Builder(builder: builder),
        barrierColor: Colors.black54,
        barrierDismissible: true,
        opaque: false,
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
}
