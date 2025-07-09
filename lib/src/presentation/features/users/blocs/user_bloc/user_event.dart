part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.createUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) = _CreateUser;

  factory UserEvent.deleteUser(String userUuid) = _DeleteUser;

  factory UserEvent.updateUser({
    required String uuid,
    required String? username,
    required String? firstName,
    required String? lastName,
    required String? email,
    required String? phone,
  }) = _UpdateUser;

  factory UserEvent.changePassword({
    required String uuid,
    required String oldPassword,
    required String newPassword,
  }) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;
}

final class _CreateUser implements UserEvent {
  _CreateUser({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
}

final class _DeleteUser implements UserEvent {
  _DeleteUser(this.userUuid);

  final String userUuid;
}

final class _UpdateUser implements UserEvent {
  _UpdateUser({
    required this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
  });

  final String uuid;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
}

class _ChangeUserPassword implements UserEvent {
  _ChangeUserPassword({
    required this.uuid,
    required this.oldPassword,
    required this.newPassword,
  });

  final String uuid;
  final String oldPassword;
  final String newPassword;
}

class _ResetUserPassword implements UserEvent {
  _ResetUserPassword(this.userUuid);

  final String userUuid;
}
