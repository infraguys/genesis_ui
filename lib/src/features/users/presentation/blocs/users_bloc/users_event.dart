part of 'users_bloc.dart';

sealed class UsersEvent {
  factory UsersEvent.getUsers() = _GetUsers;

  factory UsersEvent.deleteUsers(List<User> users) {
    final ids = users.map((it) => it.uuid).toList();
    return _DeleteUsers(ids);
  }

  factory UsersEvent.forceConfirmEmails(List<User> users) = _ForceConfirmEmails;
}

final class _GetUsers implements UsersEvent {}

final class _DeleteUsers implements UsersEvent {
  _DeleteUsers(this.ids);

  final List<UserID> ids;
}

final class _ForceConfirmEmails implements UsersEvent {
  _ForceConfirmEmails(this.users);

  final List<User> users;
}
