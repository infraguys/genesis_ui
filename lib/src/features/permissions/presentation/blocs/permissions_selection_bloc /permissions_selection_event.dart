part of 'permissions_selection_bloc .dart';

sealed class PermissionsSelectionEvent {
  factory PermissionsSelectionEvent.togglePermission(Permission permission) => _TogglePermission(permission);
}

final class _TogglePermission implements PermissionsSelectionEvent {
  _TogglePermission(this.permission);

  final Permission permission;
}
