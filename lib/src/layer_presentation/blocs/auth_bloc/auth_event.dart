part of 'auth_bloc.dart';

sealed class AuthEvent {
  factory AuthEvent.signIn(GetTokenParams params) = _SingIn;

  factory AuthEvent.signOut() = _SingOut;

  factory AuthEvent.restoreSession() = _RestoreSession;

  factory AuthEvent.refreshToken(RefreshTokenParams params) = _RefreshToken;
}

final class _SingIn implements AuthEvent {
  _SingIn(this.params);

  final GetTokenParams params;
}

final class _SingOut implements AuthEvent {}

final class _RestoreSession implements AuthEvent {}

final class _RefreshToken implements AuthEvent {
  _RefreshToken(this._params);

  final RefreshTokenParams _params;
}
