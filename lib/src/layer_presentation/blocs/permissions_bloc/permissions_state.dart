part of 'permissions_bloc.dart';

sealed class PermissionsState {
  factory PermissionsState.initial() = PermissionsInitialState;

  factory PermissionsState.loading() = PermissionsLoadingState;

  factory PermissionsState.loaded(List<Permission> permission, [List<Permission> grantedPermissions]) =
      PermissionsLoadedState;
}

final class PermissionsInitialState implements PermissionsState {}

final class PermissionsLoadingState implements PermissionsState {}

final class PermissionsLoadedState implements PermissionsState {
  PermissionsLoadedState(this.permissions, [this.grantedPermissions = const []]);

  final List<Permission> permissions;
  final List<Permission> grantedPermissions;
}
