part of 'permissions_bloc.dart';

sealed class PermissionsEvent {
  factory PermissionsEvent.getPermissions() = _GetPermissions;
}

final class _GetPermissions implements PermissionsEvent {}
