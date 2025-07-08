part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = LoadingUserState;

  factory UserState.userCreated() = UserStateCreatedSuccess;

  factory UserState.createdFailure(String message) = UserStateCreatedFailure;

  factory UserState.deleteSuccess() = DeleteSuccessUserState;
}

final class UserStateInit implements UserState {}

final class LoadingUserState implements UserState {}

final class UserStateCreatedSuccess implements UserState {}

final class DeleteSuccessUserState implements UserState {}

final class UserStateCreatedFailure implements UserState {
  UserStateCreatedFailure(this.message);

  final String message;
}
