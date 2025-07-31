part of 'permissions_selection_bloc .dart';

sealed class PermissionsSelectionEvent {
  factory PermissionsSelectionEvent.togglePermission(Permission permission) = _TogglePermission;

  factory PermissionsSelectionEvent.selectAll(List<Permission> permissions) = _SelectAllPermissions;
}

final class _TogglePermission implements PermissionsSelectionEvent {
  _TogglePermission(this.permission);

  final Permission permission;
}

final class _SelectAllPermissions implements PermissionsSelectionEvent {
  _SelectAllPermissions(this.permissions);

  final List<Permission> permissions;
}
