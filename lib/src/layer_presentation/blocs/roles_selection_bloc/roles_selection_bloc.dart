import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

part 'roles_selection_event.dart';

class RolesSelectionBloc extends Bloc<RolesSelectionEvent, List<Role>> {
  RolesSelectionBloc() : super(List.empty()) {
    on(_onToggle);
    on(_onToggleAll);
    on(_onClear);
  }

  void _onToggle(_Toggle event, Emitter<List<Role>> emit) {
    final updatedPermissions = List.of(state);
    if (updatedPermissions.contains(event.role)) {
      updatedPermissions.remove(event.role);
    } else {
      updatedPermissions.add(event.role);
    }
    emit(updatedPermissions);
  }

  void _onToggleAll(_ToggleAll event, Emitter<List<Role>> emit) {
    if (state.length == event.roles.length) {
      emit(List.empty());
    } else {
      emit(event.roles);
    }
  }

  void _onClear(_Clear _, Emitter<List<Role>> emit) {
    emit(List.empty());
  }
}
