part of 'auth_bloc.dart';

sealed class AuthState {
  factory AuthState.init() = AuthStateInit;

  factory AuthState.singInSuccess() = SignInSuccess;
}

final class AuthStateInit implements AuthState {}

final class SignInSuccess implements AuthState {}
