part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserInitialState;

  factory UserState.loading() = UserLoadingState;

  factory UserState.loaded(User user) = UserLoadedState;

  factory UserState.updated(User user) = UserUpdatedState;

  factory UserState.created(User user) = UserCreatedState;

  factory UserState.deleted(User user) = UserDeletedState;

  factory UserState.confirmed() = UserConfirmedState;

  factory UserState.failure(String message) = UserFailureState;

  factory UserState.permissionFailure(String message) = UserFailureState;
}

final class UserInitialState implements UserState {}

final class UserLoadingState implements UserState {}

final class UserLoadedState implements UserState {
  UserLoadedState(this.user);

  final User user;
}

final class UserFailureState implements UserState {
  UserFailureState(this.message);

  final String message;
}

final class UserPermissionFailureState implements UserState {
  UserPermissionFailureState(this.message);

  final String message;
}

final class UserUpdatedState implements UserState {
  UserUpdatedState(this.user);

  final User user;
}

final class UserConfirmedState implements UserState {}

final class UserCreatedState implements UserState {
  UserCreatedState(this.user);

  final User user;
}

final class UserDeletedState implements UserState {
  UserDeletedState(this.user);

  final User user;
}
