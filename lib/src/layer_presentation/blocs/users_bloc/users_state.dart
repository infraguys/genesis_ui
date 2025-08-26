part of 'users_bloc.dart';

sealed class UsersState {
  factory UsersState.initial() = UsersInitialState;

  factory UsersState.loading() = UsersLoadingState;

  factory UsersState.loaded(List<User> users) = UsersLoadedState;
}

final class UsersInitialState implements UsersState {}

final class UsersLoadingState implements UsersState {}

final class UsersLoadedState implements UsersState {
  UsersLoadedState(this.users);

  final List<User> users;
}
