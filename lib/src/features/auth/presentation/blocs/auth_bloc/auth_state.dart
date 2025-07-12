part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.authenticated(User user) = AuthenticatedAuthState;

  factory AuthState.unauthenticated() = UnauthenticatedAuthState;

  factory AuthState.loading() = AuthStateLoading;

  factory AuthState.failure(String message) = AuthStateFailure;
}

final class AuthStateLoading implements AuthState {}

final class AuthStateFailure implements AuthState {
  AuthStateFailure(this.message);

  final String message;
}

final class AuthenticatedAuthState implements AuthState {
  AuthenticatedAuthState(this.user);

  final User user;
}

final class UnauthenticatedAuthState implements AuthState {}
