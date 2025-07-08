part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _CreateUser;

  factory UserEvent.deleteUser(String userUuid) = _DeleteUser;
}

final class _CreateUser implements UserEvent {
  _CreateUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
}

final class _DeleteUser implements UserEvent {
  _DeleteUser(this.userUuid);

  final String userUuid;
}