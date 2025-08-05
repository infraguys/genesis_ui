import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/params/create_role_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_roles_repositories.dart';
import 'package:genesis/src/layer_domain/use_cases/create_role_usecase.dart';

part 'role_editor_event.dart';
part 'role_editor_state.dart';

class RoleEditorBloc extends Bloc<RoleEditorEvent, RoleEditorState> {
  RoleEditorBloc(this._rolesRepository) : super(RoleEditorState.initial()) {
    on(_onCreateRole);
    // on(_onUpdateRole);
  }

  final IRolesRepository _rolesRepository;

  Future<void> _onCreateRole(_CreateRole event, Emitter<RoleEditorState> emit) async {
    final useCase = CreateRoleUseCase(_rolesRepository);
    final params = CreateRoleParams(
      name: event.name,
      description: event.description,
      permissions: event.permissions,
    );
    emit(RoleEditorState.loading());
    await useCase(params);
  }
}
