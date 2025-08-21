part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserInitialState;

  factory UserState.loading() = UserLoadingState;

  factory UserState.updated() = UserUpdatedState;

  factory UserState.failure(String message) = UserFailureState;

  factory UserState.created(User user) = UserCreatedState;

  factory UserState.deleted() = UserDeletedState;

  factory UserState.confirmed() = UserConfirmedState;
}

final class UserInitialState implements UserState {}

final class UserLoadingState implements UserState {}

final class UserFailureState implements UserState {
  UserFailureState(this.message);

  final String message;
}

final class UserUpdatedState implements UserState {}

final class UserConfirmedState implements UserState {}

final class UserCreatedState implements UserState {
  UserCreatedState(this.user);

  final User user;
}

final class UserDeletedState implements UserState {}
