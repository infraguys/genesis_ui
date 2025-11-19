import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/dbaas/data/repositories/clusters_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_database_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_users_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/databases_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/db_versions_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/pg_users_api.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_database_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_user_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/extensions/data/repositories/extensions_repository.dart';
import 'package:genesis/src/features/extensions/data/source/extensions_api.dart';
import 'package:genesis/src/features/extensions/domain/repositories/i_extensions_repository.dart';
import 'package:genesis/src/features/iam_client/data/repositories/auth_repository.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/sources/api_url_dao.dart';
import 'package:genesis/src/features/iam_client/sources/remote_iam_client_api.dart';
import 'package:genesis/src/features/iam_client/sources/token_dao.dart';
import 'package:genesis/src/features/nodes/data/repositories/nodes_repository.dart';
import 'package:genesis/src/features/nodes/data/sources/nodes_api.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/features/organizations/data/repositories/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/permissions/data/repositories/permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/data/repositories/permissions_repository.dart';
import 'package:genesis/src/features/permissions/data/sources/permission_binding_api.dart';
import 'package:genesis/src/features/permissions/data/sources/permissions_api.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/role_bindings_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/roles_repository.dart';
import 'package:genesis/src/features/roles/data/sources/role_bindings_api.dart';
import 'package:genesis/src/features/roles/data/sources/roles_api.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/users/data/repositories/users_repository.dart';
import 'package:genesis/src/features/users/data/sources/users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class DiContainer extends StatelessWidget {
  const DiContainer({
    required this.simpleStorageClient,
    required this.secureStorageClient,
    required this.child,
    super.key,
  });

  final Widget child;
  final ISimpleStorageClient simpleStorageClient;
  final ISecureStorageClient secureStorageClient;

  static final _log = Logger('DiContainer');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ISimpleStorageClient>.value(
          value: simpleStorageClient,
        ),
        Provider<ISecureStorageClient>.value(
          value: secureStorageClient,
        ),
        Provider<RestClient>(
          create: (context) {
            IBaseStorageClient storage = context.read<ISecureStorageClient>();
            if (kIsWeb) {
              final uri = Uri.base;

              final isHttp = uri.scheme == 'http';
              if (isHttp) {
                storage = context.read<ISimpleStorageClient>();
              }
            }
            return RestClient(storage);
          },
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
            create: (context) {
              final usersApi = UsersApi(context.read<RestClient>());
              return UsersRepository(usersApi);
            },
          ),
          RepositoryProvider<IProjectsRepository>(
            create: (context) {
              final projectsApi = ProjectsApi(context.read<RestClient>());
              return ProjectsRepository(projectsApi);
            },
          ),
          RepositoryProvider<IRolesRepository>(
            create: (context) {
              final rolesApi = RolesApi(context.read<RestClient>());
              return RolesRepository(rolesApi);
            },
          ),
          RepositoryProvider<IOrganizationsRepository>(
            create: (context) {
              final organizationsApi = OrganizationsApi(context.read<RestClient>());
              return OrganizationsRepository(organizationsApi);
            },
          ),
          RepositoryProvider<IPermissionsRepository>(
            create: (context) {
              final permissionsApi = PermissionsApi(context.read<RestClient>());
              return PermissionsRepository(permissionsApi);
            },
          ),
          RepositoryProvider<IRoleBindingsRepository>(
            create: (context) {
              final roleBindingsApi = RoleBindingsApi(context.read<RestClient>());
              return RoleBindingsRepository(roleBindingsApi);
            },
          ),
          RepositoryProvider<IPermissionBindingsRepository>(
            create: (context) {
              final permissionBindingsApi = PermissionBindingsApi(context.read<RestClient>());
              return PermissionBindingsRepository(permissionBindingsApi);
            },
          ),
          RepositoryProvider<IExtensionsRepository>(
            create: (context) {
              final extensionApi = ExtensionsApi(context.read<RestClient>());
              return ExtensionsRepository(extensionApi);
            },
          ),
          RepositoryProvider<INodesRepository>(
            create: (context) {
              final nodesApi = NodesApi(context.read<RestClient>());
              return NodesRepository(nodesApi);
            },
          ),
          RepositoryProvider<IClustersRepository>(
            create: (context) {
              final nodesApi = ClustersApi(context.read<RestClient>());
              return ClustersRepository(nodesApi);
            },
          ),
          RepositoryProvider<IPgUsersRepository>(
            create: (context) {
              final pgUsersApi = PgUsersApi(context.read<RestClient>());
              return PgUsersRepository(pgUsersApi);
            },
          ),
          RepositoryProvider<IDatabaseRepository>(
            create: (context) {
              final databasesApi = PgDatabasesApi(context.read<RestClient>());
              return PgDatabasesRepository(databasesApi);
            },
          ),
          RepositoryProvider<IDBVersionsRepository>(
            create: (context) {
              final dbVersionsApi = DbVersionsApi(context.read<RestClient>());
              return DbVersionsRepository(dbVersionsApi);
            },
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              lazy: false,
              create: (context) {
                final dao = ApiUrlDao(context.read<ISimpleStorageClient>());
                return DomainSetupCubit(dao);
              },
            ),
            BlocProvider(
              create: (context) {
                return AuthBloc(context.read<IAuthRepository>(), context.read<IUsersRepository>());
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IUsersRepository>();
                return UsersBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IProjectsRepository>();
                return ProjectsBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                return RolesBloc(
                  rolesRepository: context.read<IRolesRepository>(),
                  permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
                  roleBindingsRepository: context.read<IRoleBindingsRepository>(),
                );
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IRolesRepository>();
                return UserRolesBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IOrganizationsRepository>();
                return OrganizationsBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IRoleBindingsRepository>();
                return RoleBindingsBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<INodesRepository>();
                return NodesBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                return ClustersBloc(context.read<IClustersRepository>())..add(
                  ClustersEvent.getClusters(),
                );
              },
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
