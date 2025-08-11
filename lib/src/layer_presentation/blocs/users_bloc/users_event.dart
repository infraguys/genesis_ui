part of 'users_bloc.dart';

sealed class UsersEvent {
  factory UsersEvent.getUsers() = _GetUsers;

  factory UsersEvent.deleteUsers(List<String> userUuids) = _DeleteUsers;
}

final class _GetUsers implements UsersEvent {}

final class _DeleteUsers implements UsersEvent {
  _DeleteUsers(this.userUuids);

  final List<String> userUuids;
}
