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
        Provider<ISecureStorageClient>.value(
          value: secureStorageClient,
        ),
        Provider<RestClient>(
          create: diFactory.createRestClient,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(
            create: diFactory.auth.createAuthRepository,
          ),
          RepositoryProvider<IUsersRepository>(
            create: diFactory.users.createUsersRepository,
          ),
          RepositoryProvider<IProjectsRepository>(
            create: diFactory.projects.createProjectsRepository,
          ),
          RepositoryProvider<IRolesRepository>(
            create: diFactory.roles.createRolesRepository,
          ),
          RepositoryProvider<IOrganizationsRepository>(
            create: diFactory.organizations.createOrganizationsRepository,
          ),
          RepositoryProvider<IPermissionsRepository>(
            create: diFactory.permissions.createPermissionsRepository,
          ),
          RepositoryProvider<IRoleBindingsRepository>(
            create: diFactory.roleBindings.createRoleBindingsRepository,
          ),
          RepositoryProvider<IPermissionBindingsRepository>(
            create: diFactory.permissionBindings.createPermissionBindingsRepository,
          ),
          RepositoryProvider<IExtensionsRepository>(
            create: diFactory.extensions.createExtensionsRepository,
          ),
          RepositoryProvider<INodesRepository>(
            create: diFactory.nodes.createNodesRepository,
          ),
          RepositoryProvider<IClustersRepository>(
            create: diFactory.clusters.createClustersRepository,
          ),
          RepositoryProvider<IPgUsersRepository>(
            create: diFactory.dbaas.createPgUsersRepository,
          ),
          RepositoryProvider<IDatabaseRepository>(
            create: diFactory.dbaas.createDatabasesRepository,
          ),
          RepositoryProvider<IDBVersionsRepository>(
            create: diFactory.dbaas.createDbVersionsRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: diFactory.createDomainSetupCubit,
            ),
            BlocProvider(
              create: diFactory.auth.createAuthBloc,
            ),
            BlocProvider(
              create: diFactory.users.createUsersBloc,
            ),
            BlocProvider(
              create: diFactory.projects.createProjectsBloc,
            ),
            BlocProvider(
              create: diFactory.roles.createRolesBloc,
            ),
            BlocProvider(
              create: diFactory.roles.createUserRolesBloc,
            ),
            BlocProvider(
              create: diFactory.organizations.createOrganizationsBloc,
            ),
            BlocProvider(
              create: diFactory.roleBindings.createRoleBindingsBloc,
            ),
            BlocProvider(
              create: diFactory.nodes.createNodesBloc,
            ),
            BlocProvider(
              create: (context) => diFactory.clusters.createClustersBloc(context)..add(ClustersEvent.getClusters()),
            ),
            Provider(
              create: createRouter,
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}
