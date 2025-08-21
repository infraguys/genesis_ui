part of 'user_bloc.dart';

sealed class UserState {
  factory UserState.init() = UserStateInit;

  factory UserState.loading() = UserStateLoading;

  factory UserState.success() = UserStateSuccess;

  factory UserState.failure(String message) = UserStateFailure;

  factory UserState.createdUser(User user) = UserCreatedState;
}

final class UserStateInit implements UserState {}

final class UserStateLoading implements UserState {}

final class UserStateFailure implements UserState {
  UserStateFailure(this.message);

  final String message;
}

final class UserStateSuccess implements UserState {}

final class UserCreatedState implements UserState {
  UserCreatedState(this.user);

  final User user;
}
