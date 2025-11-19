part of 'roles_bloc.dart';

sealed class RolesEvent {
  factory RolesEvent.getRoles([GetRolesParams params]) = _GetRoles;

  factory RolesEvent.deleteRoles(List<Role> roles) = _DeleteRoles;
}

final class _GetRoles implements RolesEvent {
  const _GetRoles([this.params = const GetRolesParams()]);

  final GetRolesParams params;
}

final class _DeleteRoles implements RolesEvent {
  _DeleteRoles(this.roles);

  final List<Role> roles;
}
