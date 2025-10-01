part of 'users_bloc.dart';

sealed class UsersState {
  factory UsersState.initial() = UsersInitialState;

  factory UsersState.loading() = UsersLoadingState;

  factory UsersState.loaded(List<User> users) = UsersLoadedState;

  factory UsersState.deleted(List<User> users) = UsersDeletedState;

  factory UsersState.failure(String message) = UsersFailureState;

  factory UsersState.permissionFailure(String message) = UsersPermissionFailureState;
}

final class UsersInitialState implements UsersState {}

final class UsersLoadingState implements UsersState {}

final class UsersDeletedState extends _UsersDataState {
  UsersDeletedState(super.users);
}

final class UsersLoadedState extends _UsersDataState {
  UsersLoadedState(super.users);
}

// Base classes to reduce code duplication

base class _UsersDataState implements UsersState {
  _UsersDataState(this.users);

  final List<User> users;
}

final class UsersFailureState extends _FailureState {
  UsersFailureState(super.message);
}

final class UsersPermissionFailureState extends _FailureState {
  UsersPermissionFailureState(super.message);
}

base class _FailureState implements UsersState {
  _FailureState(this.message);

  final String message;
}
