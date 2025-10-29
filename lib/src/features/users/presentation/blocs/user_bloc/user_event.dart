part of 'user_bloc.dart';

sealed class UserEvent {
  factory UserEvent.getUser(UserID uuid) = _GetUser;

  factory UserEvent.deleteUser(User user) = _DeleteUser;

  factory UserEvent.createUser(CreateUserParams params) = _CreateUser;

  factory UserEvent.update(UpdateUserParams params) = _UpdateUser;

  factory UserEvent.changePassword(ChangeUserPasswordParams params) = _ChangeUserPassword;

  factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;

  factory UserEvent.confirmEmails(List<User> users) = _ConfirmEmails;

  factory UserEvent.forceConfirmEmail(User user) = _ForceConfirmEmail;
}

final class _GetUser implements UserEvent {
  _GetUser(this.uuid);

  final UserID uuid;
}

final class _CreateUser implements UserEvent {
  _CreateUser(this.params);

  final CreateUserParams params;
}

final class _DeleteUser implements UserEvent {
  _DeleteUser(this.user);

  final User user;
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
  _ConfirmEmails(this.users);

  final List<User> users;
}

final class _ForceConfirmEmail implements UserEvent {
  _ForceConfirmEmail(this.user);

  final User user;
}
