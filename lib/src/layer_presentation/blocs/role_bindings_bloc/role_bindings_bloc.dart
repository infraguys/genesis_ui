import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/repositories/i_role_bindings_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/role_bindings/delete_role_binding.dart';

part 'role_bindings_event.dart';
part 'role_bindings_state.dart';

class RoleBindingsBloc extends Bloc<RoleBindingsEvent, RoleBindingsState> {
  RoleBindingsBloc(this._repository) : super(RoleBindingsState.initial()) {
    on<_Delete>(_onDelete);
  }

  final IRoleBindingsRepository _repository;

  Future<void> _onDelete(_Delete event, Emitter<RoleBindingsState> emit) async {
    final useCase = DeleteRoleBindingUseCase(_repository);
    emit(RoleBindingsState.loading());
    await useCase(event.uuid);
    emit(RoleBindingsState.deleted());
  }
}
