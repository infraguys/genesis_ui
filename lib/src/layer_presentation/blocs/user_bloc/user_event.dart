part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.deleteUser(DeleteUserParams params) = _DeleteUser;

  factory UserEvent.updateUser({
    required String uuid,
    String? username,
    String? description,
    String? firstName,
    String? lastName,
    String? surname,
    String? phone,
    String? email,
  }) = _UpdateUser;

  factory UserEvent.changePassword({
    required String uuid,
    required String oldPassword,
    required String newPassword,
  }) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;
}

final class _DeleteUser implements UserEvent {
  _DeleteUser(this.params);

  final DeleteUserParams params;
}

final class _UpdateUser implements UserEvent {
  _UpdateUser({
    required this.uuid,
    this.username,
    this.description,
    this.firstName,
    this.lastName,
    this.surname,
    this.phone,
    this.email,
  });

  final String uuid;
  final String? username;
  final String? description;
  final String? firstName;
  final String? lastName;
  final String? surname;
  final String? phone;
  final String? email;
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
