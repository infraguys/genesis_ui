import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/layer_data/repositories/auth_repository.dart';
import 'package:genesis/src/layer_data/repositories/organizations_repository.dart';
import 'package:genesis/src/layer_data/repositories/permission_bindings_repository.dart';
import 'package:genesis/src/layer_data/repositories/permissions_repository.dart';
import 'package:genesis/src/layer_data/repositories/projects_repository.dart';
import 'package:genesis/src/layer_data/repositories/role_bindings_repository.dart';
import 'package:genesis/src/layer_data/repositories/roles_repository.dart';
import 'package:genesis/src/layer_data/repositories/users_repository.dart';
import 'package:genesis/src/layer_data/source/local/token_dao.dart';
import 'package:genesis/src/layer_data/source/remote/organizations_api.dart';
import 'package:genesis/src/layer_data/source/remote/permission_binding_api.dart';
import 'package:genesis/src/layer_data/source/remote/permissions_api.dart';
import 'package:genesis/src/layer_data/source/remote/projects_api.dart';
import 'package:genesis/src/layer_data/source/remote/remote_iam_client_api.dart';
import 'package:genesis/src/layer_data/source/remote/role_bindings_api.dart';
import 'package:genesis/src/layer_data/source/remote/roles_api.dart';
import 'package:genesis/src/layer_data/source/remote/users_api.dart';
import 'package:genesis/src/layer_domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/repositories/i_users_repository.dart';
import 'package:genesis/src/layer_presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/layer_presentation/blocs/users_bloc/users_bloc.dart';
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
        Provider<SecureStorageClient>(
          create: (_) => FlutterSecureStorageClient(),
        ),
        Provider<RestClient>(
          create: (context) => RestClient(context.read<SecureStorageClient>()),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IAuthRepository>(
            create: (context) {
              final tokenDao = TokenDao(context.read<SecureStorageClient>());
              final iamApi = RemoteIamClientApi(context.read<RestClient>());
              return AuthRepository(iamApi: iamApi, tokenDao: tokenDao);
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
              final roleBindingApi = RoleBindingsApi(context.read<RestClient>());
              final roleApi = RolesApi(context.read<RestClient>());
              return ProjectsRepository(projectsApi, roleBindingApi, roleApi);
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
        ],
        child: MultiProvider(
          providers: [
            BlocProvider(
              create: (context) {
                final repository = context.read<IAuthRepository>();
                return AuthBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) {
                final repository = context.read<IUsersRepository>();
                return UserBloc(repository);
              },
            ),
            BlocProvider(
              create: (context) => ProjectBloc(
                projectsRepository: context.read<IProjectsRepository>(),
                roleBindingsRepository: context.read<IRoleBindingsRepository>(),
              ),
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
