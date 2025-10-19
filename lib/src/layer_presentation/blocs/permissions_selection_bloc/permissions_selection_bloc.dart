import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

part 'permissions_selection_event.dart';

// TODO: Поменять стейт на Мар
class PermissionsSelectionBloc extends Bloc<PermissionsSelectionEvent, List<Permission>> {
  PermissionsSelectionBloc() : super(List.empty()) {
    on(_onToggle);
    on(_onToggleAll);
    on(_onSetCheckedFromResponse);
    on(_onClear);
  }

  void _onToggle(_Toggle event, Emitter<List<Permission>> emit) {
    final updatedPermissions = List.of(state);
    if (updatedPermissions.contains(event.permission)) {
      updatedPermissions.remove(event.permission);
    } else {
      updatedPermissions.add(event.permission);
    }
    emit(updatedPermissions);
  }

  void _onToggleAll(_ToggleAll event, Emitter<List<Permission>> emit) {
    if (state.length == event.permissions.length) {
      emit(List.empty());
    } else {
      emit(event.permissions);
    }
  }

  void _onSetCheckedFromResponse(_SetCheckedFromResponse event, Emitter<List<Permission>> emit) {
    final permissions = <Permission>[];
    for (var binding in event.bindings) {
      final permission = event.allPermissions.singleWhere((it) => it.id.isEqualTo(binding.permissionId));
      permissions.add(permission);
    }
    emit(permissions);
  }

  void _onClear(_Clear _, Emitter<List<Permission>> emit) {
    emit(List.empty());
  }
}
