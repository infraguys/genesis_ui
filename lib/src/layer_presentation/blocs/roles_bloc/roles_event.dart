part of 'roles_bloc.dart';

sealed class RolesEvent {
  factory RolesEvent.getRoles() = _GetRoles;

  factory RolesEvent.deleteRoles(List<Role> roles) = _DeleteRoles;
}

final class _GetRoles implements RolesEvent {
  _GetRoles({this.userUuid, this.projectUuid});

  final String? userUuid;

  final String? projectUuid;
}

final class _DeleteRoles implements RolesEvent {
  _DeleteRoles(this.roles);

  final List<Role> roles;
}
