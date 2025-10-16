import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/pg_instances_api.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_pg_instances_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/pg_instances_bloc/pg_instances_bloc.dart';
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
import 'package:genesis/src/features/organizations/data/repositories/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/permissions/data/repositories/permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/data/repositories/permissions_repository.dart';
import 'package:genesis/src/features/permissions/data/requests/permissions_api.dart';
import 'package:genesis/src/features/permissions/data/sources/permission_binding_api.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/role_bindings_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/roles_repository.dart';
import 'package:genesis/src/features/roles/data/sources/role_bindings_api.dart';
import 'package:genesis/src/features/roles/data/sources/roles_api.dart';
import 'package:genesis/src/features/users/data/repositories/users_repository.dart';
import 'package:genesis/src/features/users/data/sources/users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
import 'package:genesis/src/layer_presentation/pages/server_setup_page/page_blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/routing/app_router.dart';
import 'package:provider/provider.dart';

class DiContainer extends StatelessWidget {
  const DiContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ISimpleStorageClient>(
          create: (_) => SharedPrefStorage(),
        ),
        Provider<ISecureStorageClient>(
          create: (_) => FlutterSecureStorageClient(),
        ),
        Provider<RestClient>(
          create: (context) => RestClient(context.read<ISecureStorageClient>()),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(
            create: (context) {
              final tokenDao = TokenDao(context.read<ISecureStorageClient>());
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
          RepositoryProvider<IPgInstancesRepository>(
            create: (context) {
              final nodesApi = PgInstancesApi(context.read<RestClient>());
              return PgInstancesRepository(nodesApi);
            },
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final dao = ApiUrlDao(context.read<ISimpleStorageClient>());
                return DomainSetupCubit(dao)..readApiUrl();
              },
            ),
            BlocProvider(
              create: (context) {
                return AuthBloc(context.read<IAuthRepository>());
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
                return PgInstancesBloc(context.read<IPgInstancesRepository>())..add(
                  PgInstancesEvent.getInstances(),
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
