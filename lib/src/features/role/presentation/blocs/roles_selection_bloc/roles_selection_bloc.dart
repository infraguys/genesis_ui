import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/role.dart';

part 'roles_selection_event.dart';

class RolesSelectionBloc extends Bloc<RolesSelectionEvent, List<Role>> {
  RolesSelectionBloc() : super([]) {
    on(_onToggleRole);
    on(_onSelectAllRoles);
  }

  void _onToggleRole(_ToggleRole event, Emitter<List<Role>> emit) {
    final updatedPermissions = List.of(state);
    if (updatedPermissions.contains(event.role)) {
      updatedPermissions.remove(event.role);
    } else {
      updatedPermissions.add(event.role);
    }
    emit(updatedPermissions);
  }

  void _onSelectAllRoles(_SelectAll event, Emitter<List<Role>> emit) {
    if (state.length == event.roles.length) {
      emit([]);
      return;
    } else {
      emit(event.roles);
    }
    emit(event.roles);
  }
}
