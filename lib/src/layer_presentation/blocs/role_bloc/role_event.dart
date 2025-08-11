part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.create(CreateRoleParams params) = _CreateRole;
}

final class _CreateRole implements RoleEvent {
  const _CreateRole(this.params);

  final CreateRoleParams params;
}
