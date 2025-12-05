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

  final User user;

  @override
  bool get shouldListen => true;
}

final class UserConfirmedState extends UserState {
  @override
  bool get shouldListen => true;
}

final class UserUpdatedState extends UserState {
  UserUpdatedState(this.user);

  final User user;

  @override
  bool get shouldListen => true;
}

final class UserCreatedState extends UserState {
  UserCreatedState(this.user);

  final User user;

  @override
  bool get shouldListen => true;
}

final class UserDeletedState extends UserState {
  UserDeletedState(this.user);

  final User user;

  @override
  bool get shouldListen => true;
}

/// Failure states

final class UserFailureState extends UserState {
  UserFailureState(this.message);

  final String message;

  @override
  bool get shouldListen => false;
}

final class UserPermissionFailureState extends UserState {
  UserPermissionFailureState(this.message);

  final String message;

  @override
  bool get shouldListen => false;
}
