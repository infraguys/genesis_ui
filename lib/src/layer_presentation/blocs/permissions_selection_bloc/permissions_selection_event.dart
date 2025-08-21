part of 'permissions_selection_bloc.dart';

sealed class PermissionsSelectionEvent {
  factory PermissionsSelectionEvent.toggle(Permission permission) = _Toggle;

  factory PermissionsSelectionEvent.toggleAll(List<Permission> permissions) = _ToggleAll;

  factory PermissionsSelectionEvent.clear() = _Clear;
}

final class _Toggle implements PermissionsSelectionEvent {
  _Toggle(this.permission);

  final Permission permission;
}

final class _ToggleAll implements PermissionsSelectionEvent {
  _ToggleAll(this.permissions);

  final List<Permission> permissions;
}

final class _Clear implements PermissionsSelectionEvent {}
