part of 'role_bindings_bloc.dart';

sealed class RoleBindingsEvent {
  factory RoleBindingsEvent.delete(String uuid) = _Delete;
}

final class _Delete implements RoleBindingsEvent {
  const _Delete(this.uuid);

  final String uuid;
}
