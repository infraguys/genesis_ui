part of 'roles_bloc.dart';

sealed class RolesEvent {
  factory RolesEvent.getRoles() = _GetRoles;
}

final class _GetRoles implements RolesEvent {}
