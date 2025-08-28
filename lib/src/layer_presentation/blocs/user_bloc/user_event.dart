part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.getUser(final String uuid) = _GetUser;

  factory UserEvent.deleteUser(DeleteUserParams params) = _DeleteUser;

  factory UserEvent.createUser(CreateUserParams params) = _CreateUser;

  factory UserEvent.updateUser(UpdateUserParams params) = _UpdateUser;

  factory UserEvent.changePassword(ChangeUserPasswordParams params) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;

  factory UserEvent.confirmEmails(List<ConfirmEmailParams> users) = _ConfirmEmails;

  factory UserEvent.forceConfirmEmail(User user) = _ForceConfirmEmail;
}

final class _GetUser implements UserEvent {
  _GetUser(this.uuid);

  final String uuid;
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

final class _ChangeUserPassword implements UserEvent {
  _ChangeUserPassword(this.params);

  final ChangeUserPasswordParams params;
}

final class _ResetUserPassword implements UserEvent {
  _ResetUserPassword(this.userUuid);

  final String userUuid;
}

final class _ConfirmEmails implements UserEvent {
  _ConfirmEmails(this.params);

  final List<ConfirmEmailParams> params;
}

final class _ForceConfirmEmail implements UserEvent {
  _ForceConfirmEmail(this.user);

  final User user;
}
