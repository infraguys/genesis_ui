part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.signUpSuccess() = UserStateSignUpSuccess;

  factory UserState.signUpFailure(String message) = UserStateSignUpFailure;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateSignUpSuccess implements UserState {}

final class UserStateSignUpFailure implements UserState {
  UserStateSignUpFailure(this.message);

  final String message;
}
