part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.deleteSuccess() = UserStateDeleteSuccess;

  factory UserState.changePasswordSuccess() = UserStateChangePasswordSuccess;

  factory UserState.updateSuccess() = UserStateUpdateSuccess;

  factory UserState.failure(String message) = UserStateFailure;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateDeleteSuccess implements UserState {}

final class UserStateFailure implements UserState {
  UserStateFailure(this.message);

  final String message;
}

final class UserStateUpdateSuccess implements UserState {}

final class UserStateChangePasswordSuccess implements UserState {}
