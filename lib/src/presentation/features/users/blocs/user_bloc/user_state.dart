part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.userCreated() = UserStateCreatedSuccess;

  factory UserState.createdFailure(String message) = UserStateCreatedFailure;

  factory UserState.deleteSuccess() = UserStateDeleteSuccess;

  factory UserState.changePasswordSuccess() = UserStateChangePasswordSuccess;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateCreatedSuccess implements UserState {}

final class UserStateDeleteSuccess implements UserState {}

final class UserStateChangePasswordSuccess implements UserState {}

final class UserStateCreatedFailure implements UserState {
  UserStateCreatedFailure(this.message);

  final String message;
}
