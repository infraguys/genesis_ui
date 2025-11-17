part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  bool get isInitial => this is _InitialState;
}

final class _InitialState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthStateLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthStateFailure extends AuthState {
  AuthStateFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class UnauthenticatedAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

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

  @override
  List<Object?> get props => [user, permissionNames, refreshToken, scope];
}
