part of 'users_bloc.dart';

sealed class UsersEvent {
  factory UsersEvent.getUsers() = _GetUsers;

  factory UsersEvent.deleteUser(String userUuid) = _DeleteUser;

  factory UsersEvent.blockUser() = _BlockUser;
}

final class _GetUsers implements UsersEvent {}

final class _DeleteUser implements UsersEvent {
  _DeleteUser(this.userUuid);

  final String userUuid;
}

final class _BlockUser implements UsersEvent {}
