part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.init() = AuthStateInit;

  factory AuthState.authenticated(IamClient iamClient) = Authenticated;

  factory AuthState.loading() = AuthStateLoading;
}

final class AuthStateInit implements AuthState {}

final class AuthStateLoading implements AuthState {}

final class Authenticated implements AuthState {
  Authenticated(this.iamClient);

  final IamClient iamClient;
}

final class Unauthenticated implements AuthState {}
