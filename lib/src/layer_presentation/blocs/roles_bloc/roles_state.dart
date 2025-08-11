part of 'roles_bloc.dart';

sealed class RolesState {
  factory RolesState.init() = RolesInit;

  factory RolesState.loading() = RolesLoading;

  factory RolesState.loaded(List<Role> roles) = RolesLoaded;
}

final class RolesInit implements RolesState {}

final class RolesLoading implements RolesState {}

final class RolesLoaded implements RolesState {
  RolesLoaded(this.roles);

  final List<Role> roles;
}
