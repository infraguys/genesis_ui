part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.deleteUser(DeleteUserParams params) = _DeleteUser;

  factory UserEvent.updateUser(UpdateUserParams params) = _UpdateUser;

  factory UserEvent.changePassword(ChangeUserPasswordParams params) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;

  factory UserEvent.confirmEmail(ConfirmEmailParams params) = _ConfirmEmail;
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

final class _ConfirmEmail implements UserEvent {
  _ConfirmEmail(this.params);

  final ConfirmEmailParams params;
}
