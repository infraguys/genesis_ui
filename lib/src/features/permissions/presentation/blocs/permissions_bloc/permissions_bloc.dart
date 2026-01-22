import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permissions_params.dart';
import 'package:genesis/src/features/permissions/domain/usecases/get_permissions_usecases.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc({required GetPermissionsUseCases getPermissionsUseCases})
    : _getPermissionsUseCases = getPermissionsUseCases,
      super(PermissionsInitialState()) {
    on(_getPermissions);
    on(_onSearchPermissions);
    add(PermissionsEvent.getPermissions());
  }

  final GetPermissionsUseCases _getPermissionsUseCases;

  Future<void> _getPermissions(_GetPermissions event, Emitter<PermissionsState> emit) async {
    emit(PermissionsLoadingState());
    final permissions = await _getPermissionsUseCases(event.params);
    emit(PermissionsLoadedState(permissions: permissions));
  }

  Future<void> _onSearchPermissions(_SearchPermissions event, Emitter<PermissionsState> emit) async {
    if (state is PermissionsLoadedState) {
      final newState = (state as PermissionsLoadedState).copyWith(query: event.query);
      emit(newState);
    }
  }
}
