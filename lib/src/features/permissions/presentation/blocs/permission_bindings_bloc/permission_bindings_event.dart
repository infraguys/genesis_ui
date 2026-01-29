part of 'permission_bindings_bloc.dart';

sealed class PermissionBindingsEvent {
  factory PermissionBindingsEvent.getBindings(RoleID uuid) = _GetBindings;
}

final class _GetBindings implements PermissionBindingsEvent {
  _GetBindings(this.uuid);

  final RoleID uuid;
}
