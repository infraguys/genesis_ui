import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/interfaces/i_base_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_secure_storage_client.dart';
import 'package:genesis/src/core/interfaces/i_simple_storage_client.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:genesis/src/features/bootstrap/presentation/blocs/server_setup_cubit/domain_setup_cubit.dart';
import 'package:genesis/src/features/dbaas/data/repositories/clusters_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/db_versions_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_database_repository.dart';
import 'package:genesis/src/features/dbaas/data/repositories/pg_users_repository.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/clusters_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/databases_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/db_versions_api.dart';
import 'package:genesis/src/features/dbaas/data/source/remote/pg_users_api.dart';
import 'package:genesis/src/features/dbaas/domain/repositories/i_clusters_repository.dart';
import 'package:genesis/src/features/dbaas/presentation/blocs/clusters_bloc/clusters_bloc.dart';
import 'package:genesis/src/features/extensions/data/repositories/extensions_repository.dart';
import 'package:genesis/src/features/extensions/data/source/extensions_api.dart';
import 'package:genesis/src/features/iam_client/domain/repositories/i_auth_repository.dart';
import 'package:genesis/src/features/iam_client/sources/api_url_dao.dart';
import 'package:genesis/src/features/nodes/data/repositories/nodes_repository.dart';
import 'package:genesis/src/features/nodes/data/sources/nodes_api.dart';
import 'package:genesis/src/features/nodes/domain/repositories/i_nodes_repository.dart';
import 'package:genesis/src/features/nodes/presentation/blocs/nodes_bloc/nodes_bloc.dart';
import 'package:genesis/src/features/organizations/data/repositories/organizations_repository.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';
import 'package:genesis/src/features/organizations/presentation/blocs/organizations_bloc/organizations_bloc.dart';
import 'package:genesis/src/features/permissions/data/repositories/permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/data/repositories/permissions_repository.dart';
import 'package:genesis/src/features/permissions/data/sources/permission_binding_api.dart';
import 'package:genesis/src/features/permissions/data/sources/permissions_api.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/projects/data/repositories/projects_repository.dart';
import 'package:genesis/src/features/projects/data/sources/projects_api.dart';
import 'package:genesis/src/features/projects/domain/repositories/i_projects_repository.dart';
import 'package:genesis/src/features/projects/presentation/blocs/projects_bloc/projects_bloc.dart';
import 'package:genesis/src/features/roles/data/repositories/role_bindings_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/roles_repository.dart';
import 'package:genesis/src/features/roles/data/sources/role_bindings_api.dart';
import 'package:genesis/src/features/roles/data/sources/roles_api.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/roles/presentation/blocs/role_bindings_bloc/role_bindings_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';
import 'package:genesis/src/features/users/data/repositories/users_repository.dart';
import 'package:genesis/src/features/users/data/sources/users_api.dart';
import 'package:genesis/src/features/users/domain/repositories/i_users_repository.dart';
import 'package:genesis/src/features/users/domain/usecases/change_user_password_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/confirm_emails_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/create_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/force_confirm_email_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/get_user_usecase.dart';
import 'package:genesis/src/features/users/domain/usecases/update_user_usecase.dart';
import 'package:genesis/src/features/users/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:genesis/src/features/users/presentation/blocs/users_bloc/users_bloc.dart';

final class DiFactory {
  factory DiFactory() => _instance ??= DiFactory._();

  DiFactory._();

  static DiFactory? _instance;

  RestClient createRestClient(BuildContext context) {
    IBaseStorageClient storage = context.read<ISecureStorageClient>();
    if (kIsWeb && Uri.base.isScheme('http')) {
      storage = context.read<ISimpleStorageClient>();
    }
    return RestClient(storage);
  }

  /// DAO

  DomainSetupCubit createDomainSetupCubit(BuildContext context) {
    final dao = ApiUrlDao(context.read<ISimpleStorageClient>());
    return DomainSetupCubit(dao);
  }

  /// Repositories

  IUsersRepository createUsersRepository(BuildContext context) {
    final usersApi = UsersApi(context.read<RestClient>());
    return UsersRepository(usersApi);
  }

  IProjectsRepository createProjectsRepository(BuildContext context) {
    final projectsApi = ProjectsApi(context.read<RestClient>());
    return ProjectsRepository(projectsApi);
  }

  IRolesRepository createRolesRepository(BuildContext context) {
    final rolesApi = RolesApi(context.read<RestClient>());
    return RolesRepository(rolesApi);
  }

  /// Organizations

  OrganizationsRepository createOrganiztionsRepository(BuildContext context) {
    final organizationsApi = OrganizationsApi(context.read<RestClient>());
    return OrganizationsRepository(organizationsApi);
  }

  /// Permissions

  PermissionsRepository createPermissionsRepository(BuildContext context) {
    final permissionsApi = PermissionsApi(context.read<RestClient>());
    return PermissionsRepository(permissionsApi);
  }

  /// RoleBindings

  RoleBindingsRepository createRoleBindingsRepository(BuildContext context) {
    final roleBindingsApi = RoleBindingsApi(context.read<RestClient>());
    return RoleBindingsRepository(roleBindingsApi);
  }

  // PermissionBindings

  PermissionBindingsRepository createPermissionBindingsRepository(BuildContext context) {
    final permissionBindingsApi = PermissionBindingsApi(context.read<RestClient>());
    return PermissionBindingsRepository(permissionBindingsApi);
  }

  /// Nodes

  NodesRepository createNodesRepository(BuildContext context) {
    final nodesApi = NodesApi(context.read<RestClient>());
    return NodesRepository(nodesApi);
  }

  /// Extensions

  ExtensionsRepository createExtensionsRepository(BuildContext context) {
    final extensionApi = ExtensionsApi(context.read<RestClient>());
    return ExtensionsRepository(extensionApi);
  }

  /// Clusters

  ClustersRepository createClustersRepository(BuildContext context) {
    final clustersApi = ClustersApi(context.read<RestClient>());
    return ClustersRepository(clustersApi);
  }

  /// Databases

  PgDatabasesRepository createDatabasesRepository(BuildContext context) {
    final databasesApi = PgDatabasesApi(context.read<RestClient>());
    return PgDatabasesRepository(databasesApi);
  }

  PgUsersRepository createPgUsersRepository(BuildContext context) {
    final pgUsersApi = PgUsersApi(context.read<RestClient>());
    return PgUsersRepository(pgUsersApi);
  }

  DbVersionsRepository createDbVersionsRepository(BuildContext context) {
    final dbVersionsApi = DbVersionsApi(context.read<RestClient>());
    return DbVersionsRepository(dbVersionsApi);
  }

  /// Blocs

  AuthBloc createAuthBloc(BuildContext context) {
    return AuthBloc(
      context.read<IAuthRepository>(),
      context.read<IUsersRepository>(),
    );
  }

  UsersBloc createUsersBloc(BuildContext context) {
    final usersRepo = context.read<IUsersRepository>();
    return UsersBloc(usersRepo);
  }

  UserBloc createUserBloc(BuildContext context) {
    final repository = context.read<IUsersRepository>();
    return UserBloc(
      getUserUseCase: GetUserUseCase(repository),
      createUserUseCase: CreateUserUseCase(repository),
      deleteUserUseCase: DeleteUserUseCase(repository),
      changeUserPasswordUseCase: ChangeUserPasswordUseCase(repository),
      updateUserUseCase: UpdateUserUseCase(repository),
      confirmEmailsUseCase: ConfirmEmailsUseCase(repository),
      forceConfirmEmailUseCase: ForceConfirmEmailUseCase(repository),
    );
  }

  UserRolesBloc createUserRolesBloc(BuildContext context) {
    return UserRolesBloc(context.read<IRolesRepository>());
  }

  RolesBloc createRolesBloc(BuildContext context) {
    return RolesBloc(
      rolesRepository: context.read<IRolesRepository>(),
      permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
      roleBindingsRepository: context.read<IRoleBindingsRepository>(),
    );
  }

  ProjectsBloc createProjectsBloc(BuildContext context) {
    final repository = context.read<IProjectsRepository>();
    return ProjectsBloc(repository);
  }

  NodesBloc createNodesBloc(BuildContext context) {
    final repository = context.read<INodesRepository>();
    return NodesBloc(repository);
  }

  OrganizationsBloc createOrganizationsBloc(BuildContext context) {
    final repository = context.read<IOrganizationsRepository>();
    return OrganizationsBloc(repository);
  }

  RoleBindingsBloc createRoleBindingsBloc(BuildContext context) {
    return RoleBindingsBloc(context.read<IRoleBindingsRepository>());
  }

  ClustersBloc createClustersBloc(BuildContext context) {
    return ClustersBloc(context.read<IClustersRepository>());
  }
}
