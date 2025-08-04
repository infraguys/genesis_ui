part of 'create_user_bloc.dart';

sealed class CreateUserEvent {
  factory CreateUserEvent.init() = _Init;

  factory CreateUserEvent.createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _CreateUser;
}

class _Init implements CreateUserEvent {}

class _CreateUser implements CreateUserEvent {
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
