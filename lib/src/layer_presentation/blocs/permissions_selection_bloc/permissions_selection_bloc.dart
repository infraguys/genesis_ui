import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';

part 'permissions_selection_event.dart';

// TODO: Поменять стейт на Мар
class PermissionsSelectionBloc extends Bloc<PermissionsSelectionEvent, List<Permission>> {
  PermissionsSelectionBloc() : super(List.empty()) {
    on(_onTogglePermission);
    on(_onSelectAllPermissions);
    on(_onUnSelectAllPermissions);
  }

  void _onTogglePermission(_TogglePermission event, Emitter<List<Permission>> emit) {
    final updatedPermissions = List.of(state);
    if (updatedPermissions.contains(event.permission)) {
      updatedPermissions.remove(event.permission);
    } else {
      updatedPermissions.add(event.permission);
    }
    emit(updatedPermissions);
  }

  void _onSelectAllPermissions(_SelectAllPermissions event, Emitter<List<Permission>> emit) {
    if (state.length == event.permissions.length) {
      emit(List.empty());
      return;
    } else {
      emit(event.permissions);
    }
    emit(event.permissions);
  }

  void _onUnSelectAllPermissions(_UnSelectAllPermissions _, Emitter<List<Permission>> emit) {
    emit(List.empty());
  }
}
