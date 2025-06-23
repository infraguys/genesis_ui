part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.signUpSuccess() = UserStateSignUpSuccess;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateSignUpSuccess implements UserState {}
