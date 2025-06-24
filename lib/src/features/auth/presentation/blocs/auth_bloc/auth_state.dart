part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.init() = AuthStateInit;

  factory AuthState.authenticated(IamClient iamClient) = Authenticated;

  factory AuthState.unauthenticated() = Unauthenticated;

  factory AuthState.loading() = AuthStateLoading;

  factory AuthState.failure(String message) = AuthStateFailure;
}

final class AuthStateInit implements AuthState {}

final class AuthStateLoading implements AuthState {}

final class AuthStateFailure implements AuthState {
  AuthStateFailure(this.message);

  final String message;
}

final class Authenticated implements AuthState {
  Authenticated(this.iamClient);

  final IamClient iamClient;
}

final class Unauthenticated implements AuthState {}
