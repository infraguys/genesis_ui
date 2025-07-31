import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/common/shared_entities/permission.dart';

part 'permissions_selection_event.dart';

class PermissionsSelectionBloc extends Bloc<PermissionsSelectionEvent, List<Permission>> {
  PermissionsSelectionBloc() : super([]) {
    on(_onTogglePermission);
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
}
