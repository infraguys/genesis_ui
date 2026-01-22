import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission_binding.dart';

// TODO: Поменять стейт на Мар
class PermissionsSelectionCubit extends Cubit<List<Permission>> {
  PermissionsSelectionCubit() : super(List.empty());

  void onToggle(Permission permission) {
    final updatedPermissions = List.of(state);
    if (updatedPermissions.contains(permission)) {
      updatedPermissions.remove(permission);
    } else {
      updatedPermissions.add(permission);
    }
    emit(updatedPermissions);
  }

  void onToggleAll(List<Permission> permissions) {
    if (state.length == permissions.length) {
      emit(List.empty());
    } else {
      emit(permissions);
    }
  }

  void onSetCheckedFromResponse(List<Permission> permissions, List<PermissionBinding> bindings) {
    final permissions = <Permission>[];
    for (var binding in bindings) {
      final permission = permissions.singleWhere((it) => it.id.isEqualTo(binding.permissionId));
      permissions.add(permission);
    }
    emit(permissions);
  }

  void onClear() => emit(List.empty());
}
