import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/core/storage_clients/secure_storage_client.dart';
import 'package:genesis/src/core/storage_clients/shared_pref_storage.dart';
import 'package:genesis/src/features/auth/data/auth_repository.dart';
import 'package:genesis/src/features/auth/data/sources/local/token_dao.dart';
import 'package:genesis/src/features/auth/data/sources/remote/remote_iam_client_api.dart';
import 'package:genesis/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/organizations/data/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/source/remote/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/source/remote/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/presentation/blocs/project_bloc/project_bloc.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/role/data/repositories/roles_repository.dart';
import 'package:genesis/src/features/role/data/source/remote/roles_api.dart';
import 'package:genesis/src/features/role/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/role/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/users/data/repositories/users_repository.dart';
import 'package:genesis/src/features/users/data/source/remote/users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';
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
                final repository = context.read<IProjectsRepository>();
                return ProjectBloc(repository);
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
