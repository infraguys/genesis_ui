part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.deleteUser(DeleteUserParams params) = _DeleteUser;

  factory UserEvent.createUser(CreateUserParams params) = _CreateUser;

  factory UserEvent.updateUser(UpdateUserParams params) = _UpdateUser;

  factory UserEvent.changePassword(ChangeUserPasswordParams params) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;

  factory UserEvent.confirmEmails(List<ConfirmEmailParams> params) = _ConfirmEmails;
}

final class _CreateUser implements UserEvent {
  _CreateUser(this.params);

  final CreateUserParams params;
}

final class _DeleteUser implements UserEvent {
  _DeleteUser(this.params);

  final DeleteUserParams params;
}

final class _UpdateUser implements UserEvent {
  _UpdateUser(this.params);

  final UpdateUserParams params;
}

class _ChangeUserPassword implements UserEvent {
  _ChangeUserPassword(this.params);

  final ChangeUserPasswordParams params;
}

class _ResetUserPassword implements UserEvent {
  _ResetUserPassword(this.userUuid);

  final String userUuid;
}

final class _ConfirmEmails implements UserEvent {
  _ConfirmEmails(this.params);

  final List<ConfirmEmailParams> params;
}
