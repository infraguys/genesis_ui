import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/params/get_permissions_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_permissions_repository.dart';
import 'package:genesis/src/layer_domain/use_cases/permissions/get_permissions_usecases.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc(this._repository) : super(PermissionsInitialState()) {
    on(_getPermissions);
    on(_onSearchPermissions);
    add(PermissionsEvent.getPermissions());
  }

  final IPermissionsRepository _repository;

  Future<void> _getPermissions(_GetPermissions event, Emitter<PermissionsState> emit) async {
    final useCase = GetPermissionsUseCases(_repository);
    emit(PermissionsLoadingState());
    final permissions = await useCase(event.params);
    emit(PermissionsLoadedState(permissions: permissions));
  }

  Future<void> _onSearchPermissions(_SearchPermissions event, Emitter<PermissionsState> emit) async {
    if (state is PermissionsLoadedState) {
      final newState = (state as PermissionsLoadedState).copyWith(query: event.query);
      emit(newState);
    }
  }
}
