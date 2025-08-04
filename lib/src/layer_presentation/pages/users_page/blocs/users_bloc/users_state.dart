part of 'users_bloc.dart';

sealed class UsersState {}

final class UsersInitState implements UsersState {}

final class UsersLoadingState implements UsersState {}

final class UsersLoadedState implements UsersState {
  UsersLoadedState(this.users);

  final List<User> users;
}
