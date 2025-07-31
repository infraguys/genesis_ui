import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/permission.dart';

part 'permissions_selection_event.dart';

// TODO: Поменять стейт на Мар
class PermissionsSelectionBloc extends Bloc<PermissionsSelectionEvent, List<Permission>> {
  PermissionsSelectionBloc() : super([]) {
    on(_onTogglePermission);
    on(_onSelectAllPermissions);
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
      emit([]);
      return;
    } else {
      emit(event.permissions);
    }
    emit(event.permissions);
  }
}
