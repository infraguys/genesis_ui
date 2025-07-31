part of 'permissions_selection_bloc .dart';

sealed class PermissionsSelectionEvent {
  factory PermissionsSelectionEvent.addPermission(Permission permission) = _AddPermission;

  factory PermissionsSelectionEvent.removePermission(Permission permission) = _RemovePermission;
}

final class _AddPermission implements PermissionsSelectionEvent {
  _AddPermission(this.permission);

  final Permission permission;
}

final class _RemovePermission implements PermissionsSelectionEvent {
  _RemovePermission(this.permission);

  final Permission permission;
}
