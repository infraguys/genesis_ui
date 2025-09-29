part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.authenticated(({User user, PermissionNames permissionNames}) session) = AuthenticatedAuthState;

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
  AuthenticatedAuthState(({User user, PermissionNames permissionNames}) session)
    : user = session.user,
      permissionNames = session.permissionNames;

  bool isEqualUuid(UserUUID other) => user.uuid == other;

  final User user;
  final PermissionNames permissionNames;
}

final class UnauthenticatedAuthState implements AuthState {}
