import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/bootstrap/presentation/blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/features/iam_client/data/repositories/auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/sources/api_url_dao.dart';
import 'package:genesis/src/features/iam_client/sources/remote_iam_client_api.dart';
import 'package:genesis/src/features/iam_client/sources/token_dao.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/injection/di_factory.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:logging/logging.dart';
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

  static final _log = Logger('RootDi');

  @override
  Widget build(BuildContext context) {
    final diFactory = DiFactory();

    return MultiProvider(
      providers: [
        Provider<ISimpleStorageClient>.value(
          value: simpleStorageClient,
        ),
        Provider<ISecureStorageClient>.value(
          value: secureStorageClient,
        ),
        Provider<RestClient>(
          create: (context) => diFactory.createRestClient(context),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(
            create: (context) {
              var tokenDao = TokenDao(context.read<ISecureStorageClient>());
              if (kIsWeb) {
                final uri = Uri.base;

                _log.config('Uri.base: $uri');

                final isHttp = uri.scheme == 'http';
                if (isHttp) {
                  tokenDao = TokenDao(context.read<ISimpleStorageClient>());
                }
              }
              final iamApi = RemoteIamClientApi(context.read<RestClient>());
              final projectsApi = ProjectsApi(context.read<RestClient>());
              return AuthRepository(
                iamApi: iamApi,
                tokenDao: tokenDao,
                projectApi: projectsApi,
              );
            },
          ),
          RepositoryProvider<IUsersRepository>(
            create: (context) => diFactory.createUsersRepository(context),
          ),
          RepositoryProvider<IProjectsRepository>(
            create: (context) => diFactory.createProjectsRepository(context),
          ),
          RepositoryProvider<IRolesRepository>(
            create: (context) => diFactory.createRolesRepository(context),
          ),
          RepositoryProvider<IOrganizationsRepository>(
            create: (context) => diFactory.createOrganiztionsRepository(context),
          ),
          RepositoryProvider<IPermissionsRepository>(
            create: (context) => diFactory.createPermissionsRepository(context),
          ),
          RepositoryProvider<IRoleBindingsRepository>(
            create: (context) => diFactory.createRoleBindingsRepository(context),
          ),
          RepositoryProvider<IPermissionBindingsRepository>(
            create: (context) => diFactory.createPermissionBindingsRepository(context),
          ),
          RepositoryProvider<IExtensionsRepository>(
            create: (context) => diFactory.createExtensionsRepository(context),
          ),
          RepositoryProvider<INodesRepository>(
            create: (context) => diFactory.createNodesRepository(context),
          ),
          RepositoryProvider<IClustersRepository>(
            create: (context) => diFactory.createClustersRepository(context),
          ),
          RepositoryProvider<IPgUsersRepository>(
            create: (context) => diFactory.createPgUsersRepository(context),
          ),
          RepositoryProvider<IDatabaseRepository>(
            create: (context) => diFactory.createDatabasesRepository(context),
          ),
          RepositoryProvider<IDBVersionsRepository>(
            create: (context) => diFactory.createDbVersionsRepository(context),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) => diFactory.createDomainSetupCubit(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createAuthBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createUsersBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createProjectsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createRolesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createUserRolesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createOrganizationsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createRoleBindingsBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createNodesBloc(context),
            ),
            BlocProvider(
              create: (context) => diFactory.createClustersBloc(context)..add(ClustersEvent.getClusters()),
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
