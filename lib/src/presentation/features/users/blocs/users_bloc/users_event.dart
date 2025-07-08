part of 'users_bloc.dart';

sealed class UsersEvent {
  factory UsersEvent.getUsers() = _GetUsers;

  factory UsersEvent.blockUser() = _BlockUser;

  factory UsersEvent.listenDependencies() = _ListenDependencies;
}

final class _GetUsers implements UsersEvent {}

final class _BlockUser implements UsersEvent {}

final class _ListenDependencies implements UsersEvent {}
