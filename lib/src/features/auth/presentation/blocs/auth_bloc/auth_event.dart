part of 'auth_bloc.dart';

sealed class AuthEvent {
  factory AuthEvent.signIn({
    required String username,
    required String password,
  }) => _SingIn(GetTokenParams(username: username, password: password));

  factory AuthEvent.signUp({
    required String username,
    required String email,
    required String password,
  }) => _SingUp(SignUpParams(username: username, email: email, password: password));

  factory AuthEvent.signOut() = _SingOut;

  factory AuthEvent.restoreSession() = _RestoreSession;

  factory AuthEvent.refreshToken(RefreshTokenParams params) = _RefreshToken;
}

final class _SingIn implements AuthEvent {
  _SingIn(this.params);

  final GetTokenParams params;
}

final class _SingUp implements AuthEvent {
  _SingUp(this.params);

  final SignUpParams params;
}

final class _SingOut implements AuthEvent {}

final class _RestoreSession implements AuthEvent {}

final class _RefreshToken implements AuthEvent {
  _RefreshToken(this._params);

  final RefreshTokenParams _params;
}
