import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/injection/main_di_factory.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:provider/provider.dart';

class RootDi extends StatelessWidget {
  const RootDi({
    required this.simpleStorageClient,
    required this.secureStorageClient,
    required this.child,
    super.key,
  });

  final ISimpleStorageClient simpleStorageClient;
  final ISecureStorageClient secureStorageClient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final diFactory = MainDiFactory();

    return MultiProvider(
      providers: [
        Provider<ISimpleStorageClient>.value(
          value: simpleStorageClient,
        ),
        Provider<ISecureStorageClient>.value(value: secureStorageClient),
        Provider<RestClient>(
          create: (context) => diFactory.createRestClient(context),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(
            create: (context) => diFactory.auth.createAuthRepository(context),
          ),
          RepositoryProvider<IUsersRepository>(
            create: (context) => diFactory.users.createUsersRepository(context),
          ),
          RepositoryProvider<IProjectsRepository>(
            create: (context) => diFactory.projects.createProjectsRepository(context),
          ),
          RepositoryProvider<IRolesRepository>(
            create: (context) => diFactory.roles.createRolesRepository(context),
          ),
          RepositoryProvider<IOrganizationsRepository>(
            create: (context) => diFactory.organizations.createOrganiztionsRepository(context),
          ),
          RepositoryProvider<IPermissionsRepository>(
            create: (context) => diFactory.permissions.createPermissionsRepository(context),
          ),
          RepositoryProvider<IRoleBindingsRepository>(
            create: (context) => diFactory.roleBindings.createRoleBindingsRepository(context),
          ),
          RepositoryProvider<IPermissionBindingsRepository>(
            create: (context) => diFactory.permissionBindings.createPermissionBindingsRepository(context),
          ),
          RepositoryProvider<IExtensionsRepository>(
            create: (context) => diFactory.extensions.createExtensionsRepository(context),
          ),
          RepositoryProvider<INodesRepository>(
            create: (context) => diFactory.nodes.createNodesRepository(context),
          ),
          RepositoryProvider<IClustersRepository>(
            create: (context) => diFactory.clusters.createClustersRepository(context),
          ),
          RepositoryProvider<IPgUsersRepository>(
            create: (context) => diFactory.dbaas.createPgUsersRepository(context),
          ),
          RepositoryProvider<IDatabaseRepository>(
            create: (context) => diFactory.dbaas.createDatabasesRepository(context),
          ),
          RepositoryProvider<IDBVersionsRepository>(
            create: (context) => diFactory.dbaas.createDbVersionsRepository(context),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) => diFactory.createDomainSetupCubit(context),
            ),
            BlocProvider(
              create: (context) => diFactory.auth.createAuthBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.users.createUsersBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.projects.createProjectsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.roles.createRolesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.roles.createUserRolesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.organizations.createOrganizationsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.roleBindings.createRoleBindingsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.nodes.createNodesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.clusters.createClustersBloc(context)..add(ClustersEvent.getClusters()),
            ),
            Provider(
              create: (context) => createRouter(context),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}
