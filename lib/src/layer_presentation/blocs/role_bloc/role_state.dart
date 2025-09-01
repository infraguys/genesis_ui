part of 'role_bloc.dart';

sealed class RoleState {
  factory RoleState.initial() = RoleInitialState;

  factory RoleState.loading() = RoleLoadingState;

  factory RoleState.loaded(Role role) = RoleLoadedState;

  factory RoleState.updated(Role role) = RoleUpdatedState;

  factory RoleState.created() = RoleCreatedState;
}

class RoleInitialState implements RoleState {}

class RoleLoadingState implements RoleState {}

class RoleLoadedState implements RoleState {
  RoleLoadedState(this.role);

  final Role role;
}

final class RoleUpdatedState implements RoleState {
  RoleUpdatedState(this.role);

  final Role role;
}

final class RoleCreatedState implements RoleState {}

final class RoleFailureState implements RoleState {
  RoleFailureState(this.message);

  final String message;
}
