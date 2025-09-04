part of 'roles_bloc.dart';

sealed class RolesState {
  factory RolesState.init() = RolesInitState;

  factory RolesState.loading() = RolesLoadingState;

  factory RolesState.loaded(List<Role> roles) = RolesLoadedState;
}

final class RolesInitState implements RolesState {}

final class RolesLoadingState implements RolesState {}

final class RolesLoadedState implements RolesState {
  RolesLoadedState(this.roles);

  final List<Role> roles;
}
