part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.create(CreateRoleParams params) = _CreateRole;

  factory RoleEvent.update() = _UpdateRole;
}

final class _CreateRole implements RoleEvent {
  const _CreateRole(this.params);

  final CreateRoleParams params;
}

final class _UpdateRole implements RoleEvent {
  const _UpdateRole();
}
