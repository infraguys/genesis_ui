import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/permission_binding.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/get_permission_bindings_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permission_bindings_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/permission_bindings_usecases/get_permission_bindings_usecase.dart';

part 'permission_bindings_event.dart';
part 'permission_bindings_state.dart';

class PermissionBindingsBloc extends Bloc<PermissionBindingsEvent, PermissionBindingsState> {
  PermissionBindingsBloc(this._repository) : super(PermissionBindingsState.initial()) {
    on(_onGetBindings);
  }

  final IPermissionBindingsRepository _repository;

  Future<void> _onGetBindings(_GetBindings event, Emitter<PermissionBindingsState> emit) async {
    final useCase = GetPermissionBindingsUseCase(_repository);
    emit(PermissionBindingsState.loading());
    final bindings = await useCase(GetPermissionBindingsParams(role: event.role.uuid));
    emit(PermissionBindingsState.loaded(bindings));
  }
}
