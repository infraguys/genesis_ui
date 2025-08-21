part of 'role_bloc.dart';

sealed class RoleState {
  factory RoleState.initial() = RoleInitialState;

  factory RoleState.loading() = RoleLoadingState;

  factory RoleState.success() = RoleSuccessState;
}

class RoleInitialState implements RoleState {}

class RoleLoadingState implements RoleState {}

final class RoleSuccessState implements RoleState {}

final class RoleFailureState implements RoleState {
  RoleFailureState(this.message);

  final String message;
}
