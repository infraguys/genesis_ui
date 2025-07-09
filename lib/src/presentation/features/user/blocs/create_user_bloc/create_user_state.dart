part of 'create_user_bloc.dart';

sealed class CreateUserState {}

final class CreateUserStateInit implements CreateUserState {}

final class CreateUserStateLoading implements CreateUserState {}

final class CreateUserStateCreated implements CreateUserState {
  CreateUserStateCreated(this.user);

  final User user;
}

final class CreateUserStateFailure implements CreateUserState {
  CreateUserStateFailure(this.message);

  final String message;
}
