part of 'role_bloc.dart';

sealed class RoleEvent {
  factory RoleEvent.create(CreateRoleParams params) = _Create;

  factory RoleEvent.update() = _Update;
}

final class _Create implements RoleEvent {
  const _Create(this.params);

  final CreateRoleParams params;
}

final class _Update implements RoleEvent {
  const _Update();
}
