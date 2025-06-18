part of 'auth_bloc.dart';

sealed class AuthEvent {
  factory AuthEvent.signIn({
    required String username,
    required String password,
  }) = _SingIn;
}

final class _SingIn implements AuthEvent {
  _SingIn({required this.username, required this.password});

  final String username;
  final String password;
}

// class SingIn implements AuthEvent {}
