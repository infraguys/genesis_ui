part of 'user_roles_bloc.dart';

sealed class UserRolesEvent {
  factory UserRolesEvent.getRolesByUserUuid(String userUuid) = _GetRoles;
}

final class _GetRoles implements UserRolesEvent {
  _GetRoles(this.userUuid);

  final String userUuid;
}
