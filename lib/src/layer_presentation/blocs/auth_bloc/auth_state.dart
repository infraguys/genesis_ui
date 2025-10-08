part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.authenticated(AuthSession session) = AuthenticatedAuthState;

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
  AuthenticatedAuthState(AuthSession session)
    : user = session.user,
      permissionNames = session.permissionNames,
      refreshToken = session.refreshToken,
      scope = session.scope;

  bool isEqualUuid(UserUUID other) => user.uuid == other;

  final User user;
  final PermissionNames permissionNames;
  final String refreshToken;
  final String scope;
}

final class UnauthenticatedAuthState implements AuthState {}
