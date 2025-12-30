import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permission_bindings_params.dart';
import 'package:genesis/src/features/permissions/domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/features/permissions/domain/usecases/delete_permission_bindings_usecase.dart';
import 'package:genesis/src/features/permissions/domain/usecases/get_permission_bindings_usecase.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';
import 'package:genesis/src/features/roles/domain/params/get_role_bindings_params.dart';
import 'package:genesis/src/features/roles/domain/params/get_roles_params.dart';
import 'package:genesis/src/features/roles/domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/features/roles/domain/usecases/delete_role_bindings_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/delete_roles_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/get_role_bindings_usecase.dart';
import 'package:genesis/src/features/roles/domain/usecases/get_roles.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  RolesBloc({
    required IPermissionBindingsRepository permissionBindingsRepository,
    required IRoleBindingsRepository roleBindingsRepository,
    required GetRolesUseCase getRolesUseCase,
    required DeleteRolesUseCase deleteRolesUseCase,
  }) : _permissionBindingsRepository = permissionBindingsRepository,
       _roleBindingsRepository = roleBindingsRepository,
       _getRolesUseCase = getRolesUseCase,
       _deleteRolesUseCase = deleteRolesUseCase,
       super(RolesState.init()) {
    on(_onGetRoles);
    on(_onDeleteRoles);
    add(RolesEvent.getRoles());
  }

  final IPermissionBindingsRepository _permissionBindingsRepository;
  final IRoleBindingsRepository _roleBindingsRepository;
  final GetRolesUseCase _getRolesUseCase;
  final DeleteRolesUseCase _deleteRolesUseCase;

  Future<void> _onGetRoles(_GetRoles event, Emitter<RolesState> emit) async {
    emit(RolesState.loading());
    final roles = await _getRolesUseCase(event.params);
    emit(RolesState.loaded(roles));
  }

  Future<void> _onDeleteRoles(_DeleteRoles event, Emitter<RolesState> emit) async {
    final getPermissionBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final getRolesBindingsUseCase = GetRoleBindingsUseCase(_roleBindingsRepository);
    final deletePermissionBindingsUseCase = DeletePermissionBindingsUseCase(_permissionBindingsRepository);
    final deleteRolesBindingsUseCase = DeleteRoleBindingsUseCase(_roleBindingsRepository);

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
    await _deleteRolesUseCase(event.roles);
    add(RolesEvent.getRoles());
  }
}
