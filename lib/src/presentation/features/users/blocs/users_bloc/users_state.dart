part of 'users_bloc.dart';

sealed class UsersState {}

final class InitUsersState implements UsersState {}

final class LoadingUsersState implements UsersState {}

final class SuccessUsersState implements UsersState {
  SuccessUsersState(this.users);

  final List<User> users;
}
