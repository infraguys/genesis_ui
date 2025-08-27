import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/get_permission_bindings_params.dart';
import 'package:genesis/src/layer_domain/params/roles/get_roles_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/delete_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/get_permission_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/delete_roles_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/get_roles.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  RolesBloc({
    required IRolesRepository rolesRepository,
    required IPermissionBindingsRepository permissionBindingsRepository,
  }) : _rolesRepository = rolesRepository,
       _permissionBindingsRepository = permissionBindingsRepository,
       super(RolesState.init()) {
    on(_onGetRoles);
    on(_onDeleteRoles);
    add(RolesEvent.getRoles());
  }

  final IRolesRepository _rolesRepository;
  final IPermissionBindingsRepository _permissionBindingsRepository;

  Future<void> _onGetRoles(_GetRoles event, Emitter<RolesState> emit) async {
    final usesCase = GetRolesUseCase(_rolesRepository);
    emit(RolesState.loading());
    final roles = await usesCase(event.params);
    emit(RolesState.loaded(roles));
  }

  Future<void> _onDeleteRoles(_DeleteRoles event, Emitter<RolesState> emit) async {
    final getPermissionBindingsUseCase = GetPermissionBindingsUseCase(_permissionBindingsRepository);
    final deletePermissionBindingsUseCase = DeletePermissionBindingsUseCase(_permissionBindingsRepository);
    final deleteRolesUseCase = DeleteRolesUseCase(_rolesRepository);

    emit(RolesState.loading());

    final permissionBindings = await getPermissionBindingsUseCase(
      GetPermissionBindingsParams(role: event.roles.single.uuid),
    );

    await deletePermissionBindingsUseCase(permissionBindings);

    await deleteRolesUseCase(event.roles);
    add(RolesEvent.getRoles());
  }
}
