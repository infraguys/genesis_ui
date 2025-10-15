part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitialState implements UserState {}

final class UserLoadingState implements UserState {}

final class UserLoadedState extends _DataState implements UserState {
  UserLoadedState(super.user);
}

final class UserConfirmedState implements UserState {}

final class UserUpdatedState extends _DataState implements UserState {
  UserUpdatedState(super.user);
}

final class UserCreatedState extends _DataState implements UserState {
  UserCreatedState(super.user);
}

final class UserDeletedState extends _DataState implements UserState {
  UserDeletedState(super.user);
}

/// Failure states

final class UserFailureState extends _FailureState implements UserState {
  UserFailureState(super.message);
}

final class UserPermissionFailureState extends _FailureState implements UserState {
  UserPermissionFailureState(super.message);
}

/// Base classes to reduce code duplication

base class _DataState {
  _DataState(this.user);

  final User user;
}

base class _FailureState {
  _FailureState(this.message);

  final String message;
}

extension UserStateX on UserState {
  bool get shouldListen => this is! UserLoadingState && this is! UserInitialState;

  bool get shouldBuild => this is UserLoadedState || this is UserLoadingState;
}