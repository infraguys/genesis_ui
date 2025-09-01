import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/params/roles/update_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/create_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/get_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/create_role_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_role_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/update_role_usecase.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc(this._rolesRepository, this._permissionBindingsRepository) : super(RoleState.initial()) {
    on(_onCreate);
    on(_onUpdate);
    on(_onGetRole);
  }

  final IRolesRepository _rolesRepository;
  final IPermissionBindingsRepository _permissionBindingsRepository;

  Future<void> _onGetRole(_GetRole event, Emitter<RoleState> emit) async {
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

  Future<void> _onUpdate(_Update event, Emitter<RoleState> emit) async {
    final updateUseCase = UpdateRoleUseCase(_rolesRepository);
    final getPermissionBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final createPermissionBindingsUseCase = CreatePermissionBindingsUseCase(_permissionBindingsRepository);
    emit(RoleState.loading());
    final role = await updateUseCase(event.params);
    // final bindings = await getPermissionBindingsUseCase(GetPermissionBindingsParams(role: role.uuid));
    // final newPermissions = event.params.permissions;
    // for (var permission in newPermissions) {
    //   final isExist = bindings.any((it) => it.permissionUUID == permission.uuid);
    //
    // }

    emit(RoleState.updated(role));
  }
}
