part of 'permissions_bloc.dart';

sealed class PermissionsEvent {
  factory PermissionsEvent.getPermissions([GetPermissionsParams params]) = _GetPermissions;

  factory PermissionsEvent.search(String query) = _SearchPermissions;
}

final class _GetPermissions implements PermissionsEvent {
  const _GetPermissions([this.params = const GetPermissionsParams()]);

  final GetPermissionsParams params;
}

final class _SearchPermissions implements PermissionsEvent {
  const _SearchPermissions(this.query);

  final String query;
}
