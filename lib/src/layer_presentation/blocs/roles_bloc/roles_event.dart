part of 'roles_bloc.dart';

sealed class RolesEvent {
  factory RolesEvent.getRoles() = _GetRoles;

  factory RolesEvent.deleteRoles(List<DeleteRoleParams> listOfParams) = _DeleteRoles;
}

final class _GetRoles implements RolesEvent {}

final class _DeleteRoles implements RolesEvent {
  _DeleteRoles(this.listOfParams);

  final List<DeleteRoleParams> listOfParams;
}
