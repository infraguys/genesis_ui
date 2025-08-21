import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/params/roles/create_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/roles/create_role_usecase.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc(this._rolesRepository) : super(RoleState.initial()) {
    on(_onCreateRole);
    on(_onUpdateRole);
  }

  final IRolesRepository _rolesRepository;

  Future<void> _onCreateRole(_CreateRole event, Emitter<RoleState> emit) async {
    final useCase = CreateRoleUseCase(_rolesRepository);
    emit(RoleState.loading());
    await useCase(event.params);
    emit(RoleState.created());
  }

  Future<void> _onUpdateRole(_UpdateRole event, Emitter<RoleState> emit) async {}
}
