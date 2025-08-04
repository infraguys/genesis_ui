part of 'users_bloc.dart';

sealed class UsersEvent {
  factory UsersEvent.getUsers() = _GetUsers;
}

final class _GetUsers implements UsersEvent {}
