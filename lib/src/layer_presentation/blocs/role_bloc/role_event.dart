part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.get(RoleUUID uuid) = _Get;

  factory RoleEvent.create(CreateRoleParams params) = _Create;

  factory RoleEvent.update(UpdateRoleParams params) = _Update;

  factory RoleEvent.delete(Role role) = _Delete;
}

final class _Get implements RoleEvent {
  const _Get(this.uuid);

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

final class _Delete implements RoleEvent {
  const _Delete(this.role);

  final Role role;
}
