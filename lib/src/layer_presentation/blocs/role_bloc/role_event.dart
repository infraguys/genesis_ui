part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.getRole(RoleUUID uuid) = _GetRole;

  factory RoleEvent.create(CreateRoleParams params) = _Create;

  factory RoleEvent.update(UpdateRoleParams params) = _Update;
}

final class _GetRole implements RoleEvent {
  const _GetRole(this.uuid);

  final RoleUUID uuid;
}

final class _Create implements RoleEvent {
  const _Create(this.params);

  final CreateRoleParams params;
}

final class _Update implements RoleEvent {
  const _Update(this.params);

  final UpdateRoleParams params;
}
