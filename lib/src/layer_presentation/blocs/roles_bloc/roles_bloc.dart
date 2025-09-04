import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/get_permission_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/delete_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/get_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/delete_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/get_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/delete_roles_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_roles.dart';

part 'roles_event.dart';

part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  RolesBloc({
    required IRolesRepository rolesRepository,
    required IPermissionBindingsRepository permissionBindingsRepository,
    required IRoleBindingsRepository roleBindingsRepository,
  }) : _rolesRepository = rolesRepository,
       _permissionBindingsRepository = permissionBindingsRepository,
       _roleBindingsRepository = roleBindingsRepository,
       super(RolesState.init()) {
    on(_onGetRoles);
    on(_onDeleteRoles);
    add(RolesEvent.getRoles());
  }

  final IRolesRepository _rolesRepository;
  final IPermissionBindingsRepository _permissionBindingsRepository;
  final IRoleBindingsRepository _roleBindingsRepository;

  Future<void> _onGetRoles(_GetRoles event, Emitter<RolesState> emit) async {
    final usesCase = GetRolesUseCase(_rolesRepository);
    emit(RolesState.loading());
    final roles = await usesCase(event.params);
    emit(RolesState.loaded(roles));
  }

  Future<void> _onDeleteRoles(_DeleteRoles event, Emitter<RolesState> emit) async {
    final getPermissionBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final getRolesBindingsUseCase = GetRoleBindingsUseCase(_roleBindingsRepository);
    final deletePermissionBindingsUseCase = DeletePermissionBindingsUseCase(_permissionBindingsRepository);
    final deleteRolesBindingsUseCase = DeleteRoleBindingsUseCase(_roleBindingsRepository);
    final deleteRolesUseCase = DeleteRolesUseCase(_rolesRepository);

    emit(RolesState.loading());

    for (var role in event.roles) {
      final permissionBindings = await getPermissionBindingsUseCase(
        GetPermissionBindingsParams(roleUUID: role.uuid),
      );

      final roleBindings = await getRolesBindingsUseCase(
        GetRoleBindingsParams(roleUUID: role.uuid),
      );

      await deleteRolesBindingsUseCase(roleBindings);
      await deletePermissionBindingsUseCase(permissionBindings);
    }
    await deleteRolesUseCase(event.roles);
    add(RolesEvent.getRoles());
  }
}
