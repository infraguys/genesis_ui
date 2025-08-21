part of 'role_bloc.dart';

sealed class RoleState {
  factory RoleState.initial() = RoleInitialState;

  factory RoleState.loading() = RoleLoadingState;

  factory RoleState.updated() = RoleUpdatedState;

  factory RoleState.created() = RoleCreatedState;
}

class RoleInitialState implements RoleState {}

class RoleLoadingState implements RoleState {}

final class RoleUpdatedState implements RoleState {}

final class RoleCreatedState implements RoleState {}

final class RoleFailureState implements RoleState {
  RoleFailureState(this.message);

  final String message;
}
