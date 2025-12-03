part of 'user_bloc.dart';

sealed class UserState {
  bool get shouldListen;
}

final class _InitialState extends UserState {
  @override
  bool get shouldListen => false;
}

final class UserLoadingState extends UserState {
  @override
  bool get shouldListen => false;
}

final class UserLoadedState extends UserState {
  UserLoadedState(this.user);

  @override
  bool get shouldListen => true;

  final User user;
}

final class UserConfirmedState extends UserState {
  @override
  bool get shouldListen => true;
}

final class UserUpdatedState extends UserState {
  UserUpdatedState(this.user);

  @override
  bool get shouldListen => true;

  final User user;
}

final class UserCreatedState extends UserState {
  UserCreatedState(this.user);

  @override
  bool get shouldListen => true;

  final User user;
}

final class UserDeletedState extends UserState {
  UserDeletedState(this.user);

  @override
  bool get shouldListen => true;

  final User user;
}

/// Failure states

final class UserFailureState extends UserState {
  UserFailureState(this.message);

  @override
  bool get shouldListen => false;

  final String message;
}

final class UserPermissionFailureState extends UserState {
  UserPermissionFailureState(this.message);

  @override
  bool get shouldListen => false;

  final String message;
}
