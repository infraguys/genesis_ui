part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.deleteSuccess() = UserStateDeleteSuccess;

  factory UserState.changePasswordSuccess() = UserStateChangePasswordSuccess;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateDeleteSuccess implements UserState {}

final class UserStateChangePasswordSuccess implements UserState {}
