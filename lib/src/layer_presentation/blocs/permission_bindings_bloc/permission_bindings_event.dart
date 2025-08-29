part of 'permission_bindings_bloc.dart';

sealed class PermissionBindingsEvent {
  factory PermissionBindingsEvent.getBindings(Role role) = _GetBindings;
}

final class _GetBindings implements PermissionBindingsEvent {
  _GetBindings(this.role);

  final Role role;
}
