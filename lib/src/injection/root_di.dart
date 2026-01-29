import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/clusters/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/clusters/presentation/blocs/clusters_bloc/clusters_bloc.dart';
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
import 'package:genesis/src/injection/di_scope.dart';
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
    final diFactory = DiScope.of(context);

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
            create: diFactory.auth.makeAuthRepository,
          ),
          RepositoryProvider<IUsersRepository>(
            create: diFactory.users.makeUsersRepository,
          ),
          RepositoryProvider<IProjectsRepository>(
            create: diFactory.projects.makeProjectsRepository,
          ),
          RepositoryProvider<IRolesRepository>(
            create: diFactory.roles.makeRolesRepository,
          ),
          RepositoryProvider<IOrganizationsRepository>(
            create: diFactory.organizations.makeOrganizationsRepository,
          ),
          RepositoryProvider<IPermissionsRepository>(
            create: diFactory.permissions.makePermissionsRepository,
          ),
          RepositoryProvider<IRoleBindingsRepository>(
            create: diFactory.roleBindings.makeRoleBindingsRepository,
          ),
          RepositoryProvider<IPermissionBindingsRepository>(
            create: diFactory.permissionBindings.makePermissionBindingsRepository,
          ),
          RepositoryProvider<IExtensionsRepository>(
            create: diFactory.extensions.makeExtensionsRepository,
          ),
          RepositoryProvider<INodesRepository>(
            create: diFactory.nodes.makeNodesRepository,
          ),
          RepositoryProvider<IClustersRepository>(
            create: diFactory.clusters.makeClustersRepository,
          ),
          RepositoryProvider<IPgUsersRepository>(
            create: diFactory.dbaas.makePgUsersRepository,
          ),
          RepositoryProvider<IDatabaseRepository>(
            create: diFactory.dbaas.makeDatabasesRepository,
          ),
          RepositoryProvider<IDBVersionsRepository>(
            create: diFactory.dbaas.makeDbVersionsRepository,
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: diFactory.createDomainSetupCubit,
            ),
            BlocProvider(
              create: diFactory.auth.makeAuthBloc,
            ),
            BlocProvider(
              create: diFactory.users.makeUsersBloc,
            ),
            BlocProvider(
              create: diFactory.projects.makeProjectsBloc,
            ),
            BlocProvider(
              create: diFactory.roles.makeRolesBloc,
            ),
            BlocProvider(
              create: diFactory.roles.makeUserRolesBloc,
            ),
            BlocProvider(
              create: diFactory.organizations.makeOrganizationsBloc,
            ),
            BlocProvider(
              create: diFactory.roleBindings.makeRoleBindingsBloc,
            ),
            BlocProvider(
              create: diFactory.nodes.makeNodesBloc,
            ),
            BlocProvider(
              create: (context) => diFactory.clusters.makeClustersBloc(context)..add(ClustersEvent.getClusters()),
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
