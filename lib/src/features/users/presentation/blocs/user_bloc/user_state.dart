part of 'user_bloc.dart';

sealed class UserState {
  bool get shouldListen => this is! UserLoadingState && this is! _InitialState;
}

final class _InitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserLoadedState extends UserState{
  UserLoadedState(this.user);

  final User user;
}

final class UserConfirmedState extends UserState {}

final class UserUpdatedState extends UserState {
  UserUpdatedState(this.user);

  final User user;
}

final class UserCreatedState extends UserState {
  UserCreatedState(this.user);

  final User user;
}

final class UserDeletedState extends UserState {
  UserDeletedState(this.user);

  final User user;
}

/// Failure states

final class UserFailureState extends UserState {
  UserFailureState(this.message);

  final String message;
}

final class UserPermissionFailureState extends UserState {
  UserPermissionFailureState(this.message);

  final String message;
}
