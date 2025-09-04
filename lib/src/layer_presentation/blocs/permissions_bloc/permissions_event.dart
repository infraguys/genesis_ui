part of 'permissions_bloc.dart';

sealed class PermissionsEvent {
  factory PermissionsEvent.getPermissions([GetPermissionsParams params]) = _GetPermissions;
}

final class _GetPermissions implements PermissionsEvent {
  const _GetPermissions([this.params = const GetPermissionsParams()]);

  final GetPermissionsParams params;
}
