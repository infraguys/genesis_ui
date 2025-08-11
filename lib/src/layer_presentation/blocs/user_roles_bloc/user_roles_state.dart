part of 'user_roles_bloc.dart';

sealed class UserRolesState {}

final class UserRolesInit extends UserRolesState {}

final class UserRolesLoading extends UserRolesState {}

final class UserRolesLoaded extends UserRolesState {
  UserRolesLoaded(this.roles);

  final List<Role> roles;
}

final class UserRolesFailure extends UserRolesState {
  UserRolesFailure(this.message);

  final String message;
}
