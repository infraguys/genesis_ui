import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecase/create_permission_bindings.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/create_role_usecase.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc({
    required IRolesRepository rolesRepository,
    required IPermissionBindingsRepository permissionBindingsRepository,
  }) : _rolesRepository = rolesRepository,
       _iPermissionBindingsRepository = permissionBindingsRepository,
       super(RoleState.initial()) {
    on(_onCreate);
    on(_onUpdate);
  }

  final IRolesRepository _rolesRepository;
  final IPermissionBindingsRepository _iPermissionBindingsRepository;

  Future<void> _onCreate(_Create event, Emitter<RoleState> emit) async {
    final useCase = CreateRoleUseCase(_rolesRepository);
    final createPermissionBindingsUseCase = CreatePermissionBindingsUseCase(_iPermissionBindingsRepository);
    emit(RoleState.loading());
    final role = await useCase(event.params);
    final listOfBindingsParams = event.params.permissions.map(
      (it) => CreatePermissionBindingParams(permissionUuid: it.uuid, roleUuid: role.uuid),
    );
    await createPermissionBindingsUseCase(listOfBindingsParams.toList());

    emit(RoleState.created());
  }

  Future<void> _onUpdate(_Update event, Emitter<RoleState> emit) async {}
}
