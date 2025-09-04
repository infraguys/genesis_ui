part of 'users_bloc.dart';

sealed class UsersState {
  factory UsersState.initial() = UsersInitialState;

  factory UsersState.loading() = UsersLoadingState;

  factory UsersState.loaded(List<User> users) = UsersLoadedState;

  factory UsersState.deleted(List<User> users) = UsersDeletedState;
}

final class UsersInitialState implements UsersState {}

final class UsersLoadingState implements UsersState {}

final class UsersDeletedState implements UsersState {
  UsersDeletedState(this.users);

  final List<User> users;
}

final class UsersLoadedState implements UsersState {
  UsersLoadedState(this.users);

  final List<User> users;
}
