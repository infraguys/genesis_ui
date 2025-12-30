import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/roles/data/repositories/roles_repository.dart';
import 'package:genesis/src/features/roles/data/sources/roles_api.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/features/roles/domain/usecases/delete_roles_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/get_roles.dart';
import 'package:genesis/src/features/roles/presentation/blocs/roles_bloc/roles_bloc.dart';
import 'package:genesis/src/features/roles/presentation/blocs/user_roles_bloc/user_roles_bloc.dart';

final class RolesDiFactory {
  /// Repositories

  IRolesRepository makeRolesRepository(BuildContext context) {
    final rolesApi = RolesApi(context.read<RestClient>());
    return RolesRepository(rolesApi);
  }

  /// Blocs

  RolesBloc makeRolesBloc(BuildContext context) {
    final rolesRepository = context.read<IRolesRepository>();
    return RolesBloc(
      permissionBindingsRepository: context.read<IPermissionBindingsRepository>(),
      roleBindingsRepository: context.read<IRoleBindingsRepository>(),
      getRolesUseCase: GetRolesUseCase(rolesRepository),
      deleteRolesUseCase: DeleteRolesUseCase(rolesRepository),
    );
  }

  UserRolesBloc makeUserRolesBloc(BuildContext context) {
    return UserRolesBloc(context.read<IRolesRepository>());
  }
}
