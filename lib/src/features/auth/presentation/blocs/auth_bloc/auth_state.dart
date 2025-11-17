part of 'auth_bloc.dart';

sealed class AuthState {
  bool get isInitial => this is _InitialState;
}

final class _InitialState extends AuthState {}

final class AuthStateLoading extends AuthState {}

final class AuthStateFailure extends AuthState {
  AuthStateFailure(this.message);

  final String message;
}

final class UnauthenticatedAuthState extends AuthState {}

final class AuthenticatedAuthState extends AuthState {
  AuthenticatedAuthState(AuthSession session)
    : user = session.user,
      permissionNames = session.permissionNames,
      refreshToken = session.refreshToken,
      scope = session.scope;

  bool isEqualUuid(UserID other) => user.uuid == other;

  final User user;
  final PermissionNames permissionNames;
  final String refreshToken;
  final String scope;
}
