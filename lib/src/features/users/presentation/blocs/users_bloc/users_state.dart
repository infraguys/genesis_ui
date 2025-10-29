part of 'users_bloc.dart';

sealed class UsersState {}

final class _InitialState implements UsersState {}

final class UsersLoadingState implements UsersState {}

final class UsersDeletedState extends _UsersDataState {
  UsersDeletedState(super.users);
}

final class UsersLoadedState extends _UsersDataState {
  UsersLoadedState(super.users);
}

final class UsersPermissionFailureState extends _FailureState {
  UsersPermissionFailureState(super.message);
}

final class UsersFailureState extends _FailureState {
  UsersFailureState(super.message);
}

// Base classes to reduce code duplication

base class _UsersDataState implements UsersState {
  _UsersDataState(this.users);

  final List<User> users;
}

base class _FailureState implements UsersState {
  _FailureState(this.message);

  final String message;
}

extension UsersStateX on UsersState {
  bool get shouldListen => this is! UsersLoadingState && this is! _InitialState;
}
