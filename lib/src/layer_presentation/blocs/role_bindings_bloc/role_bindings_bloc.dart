import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/project.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/entities/role_binding.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/create_role_binding_params.dart';
import 'package:genesis/src/layer_domain/params/role_bindings/get_role_bindings_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/create_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/delete_role_bindings_usecase.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/get_role_bindings_usecase.dart';

part 'role_bindings_event.dart';
part 'role_bindings_state.dart';

class RoleBindingsBloc extends Bloc<RoleBindingsEvent, RoleBindingsState> {
  RoleBindingsBloc(this._repository) : super(RoleBindingsState.initial()) {
    on(_onDeleteBinding);
    on(_onCreateBindings);
  }

  final IRoleBindingsRepository _repository;

  Future<void> _onCreateBindings(_CreateBindings event, Emitter<RoleBindingsState> emit) async {
    final useCase = CreateRoleBindingsUseCase(_repository);
    emit(RoleBindingsState.loading());
    await useCase(event.listOfParams);
    emit(RoleBindingsState.created());
  }

  Future<void> _onDeleteBinding(_Delete event, Emitter<RoleBindingsState> emit) async {
    final getBindingsUseCase = GetRoleBindingsUseCase(_repository);
    final deleteRoleBindingsUseCase = DeleteRoleBindingsUseCase(_repository);

    emit(RoleBindingsState.loading());
    final bindings = await getBindingsUseCase(
      GetRoleBindingsParams(
        userUUID: event.userUUID,
        roleUUID: event.roleUUID,
        projectUUID: event.projectUUID,
      ),
    );
    await deleteRoleBindingsUseCase(bindings);
    emit(RoleBindingsState.deleted());
  }

  // Future<void> _onGetRoleBinding(_GetBinding event, Emitter<RoleBindingsState> emit) async {
  //   final getBindingUseCase = GetRoleBindingsUseCase(_repository);
  //   emit(RoleBindingsState.loading());
  //   final useCase = DeleteRoleBindingUseCase(_repository);
  //   emit(RoleBindingsState.loading());
  //   await useCase(event.uuid);
  //   emit(RoleBindingsState.deleted());
  // }
}
