part of './user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.singUp({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _SignUp;
}

final class _SignUp implements UserEvent {
  _SignUp({
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
