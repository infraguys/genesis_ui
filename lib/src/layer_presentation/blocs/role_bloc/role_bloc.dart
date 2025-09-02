import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/get_permission_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/create_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/delete_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/get_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/delete_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/get_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/create_role_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/delete_roles_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_role_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/update_role_usecase.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc({
    required IRolesRepository rolesRepository,
    required IPermissionBindingsRepository permissionBindingsRepository,
    required IRoleBindingsRepository roleBindingsRepository,
  }) : _rolesRepository = rolesRepository,
       _permissionBindingsRepository = permissionBindingsRepository,
       _roleBindingsRepository = roleBindingsRepository,
       super(RoleState.initial()) {
    on(_onGet);
    on(_onCreate);
    on(_onUpdate);
    on(_onDelete);
  }

  final IRolesRepository _rolesRepository;
  final IPermissionBindingsRepository _permissionBindingsRepository;
  final IRoleBindingsRepository _roleBindingsRepository;

  Future<void> _onGet(_Get event, Emitter<RoleState> emit) async {
    final useCase = GetRoleUseCase(_rolesRepository);
    emit(RoleState.loading());
    final role = await useCase(event.uuid);
    emit(RoleState.loaded(role));
  }

  Future<void> _onCreate(_Create event, Emitter<RoleState> emit) async {
    final useCase = CreateRoleUseCase(_rolesRepository);
    final createPermissionBindingsUseCase = CreatePermissionBindingsUseCase(_permissionBindingsRepository);
    emit(RoleState.loading());
    final role = await useCase(event.params);

    await createPermissionBindingsUseCase(permissions: event.params.permissions, roleUUID: role.uuid);

    emit(RoleState.created());
  }

  Future<void> _onDelete(_Delete event, Emitter<RoleState> emit) async {
    final getPermBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final getRolesBindingsUseCase = GetRoleBindingsUseCase(_roleBindingsRepository);
    final deleteRoleUseCase = DeleteRoleUseCase(_rolesRepository);
    final deleteRolesBindingsUseCase = DeleteRoleBindingsUseCase(_roleBindingsRepository);
    final deletePermissionBindingsUseCase = DeletePermissionBindingsUseCase(_permissionBindingsRepository);
    emit(RoleState.loading());

    final permissionBindings = await getPermBindingsUseCase(GetPermissionBindingsParams(roleUUID: event.role.uuid));
    final roleBindings = await getRolesBindingsUseCase(GetRoleBindingsParams(roleUUID: event.role.uuid));

    await deletePermissionBindingsUseCase(permissionBindings);
    await deleteRolesBindingsUseCase(roleBindings);
    await deleteRoleUseCase(event.role.uuid);

    emit(RoleState.deleted(event.role));
  }

  Future<void> _onUpdate(_Update event, Emitter<RoleState> emit) async {
    final updateUseCase = UpdateRoleUseCase(_rolesRepository);
    final getPermissionBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final createPermissionBindingsUseCase = CreatePermissionBindingsUseCase(_permissionBindingsRepository);
    final deletePermissionBindingsUseCase = DeletePermissionBindingsUseCase(_permissionBindingsRepository);
    emit(RoleState.loading());
    final role = await updateUseCase(event.params);

    final bindings = await getPermissionBindingsUseCase(GetPermissionBindingsParams(roleUUID: role.uuid));
    final newPermissions = event.params.permissions;

    await deletePermissionBindingsUseCase(bindings);
    await createPermissionBindingsUseCase(permissions: newPermissions, roleUUID: role.uuid);

    emit(RoleState.updated(role));
  }
}
