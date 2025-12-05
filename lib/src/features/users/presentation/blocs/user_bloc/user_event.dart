part of 'user_bloc.dart';

sealed class UserEvent {
  const factory UserEvent.getUser(UserID id) = _GetUser;
  const factory UserEvent.deleteUser(User user) = _DeleteUser;
  const factory UserEvent.createUser(CreateUserParams params) = _CreateUser;
  const factory UserEvent.update(UpdateUserParams params) = _UpdateUser;
  const factory UserEvent.changePassword(ChangeUserPasswordParams params) = _ChangeUserPassword;
  const factory UserEvent.forceConfirmEmail(User user) = _ForceConfirmEmail;
  const factory UserEvent.resetPassword(String userUuid) = _ResetUserPassword;
  const factory UserEvent.confirmEmails(List<User> users) = _ConfirmEmails;
}

final class _GetUser implements UserEvent {
  const _GetUser(this.id);

  final UserID id;
}

final class _CreateUser implements UserEvent {
  const _CreateUser(this.params);

  final CreateUserParams params;
}

final class _DeleteUser implements UserEvent {
  const _DeleteUser(this.user);

  final User user;
}

final class _UpdateUser implements UserEvent {
  const _UpdateUser(this.params);

  final UpdateUserParams params;
}

final class _ChangeUserPassword implements UserEvent {
  const _ChangeUserPassword(this.params);

  final ChangeUserPasswordParams params;
}

final class _ResetUserPassword implements UserEvent {
  const _ResetUserPassword(this.userUuid);

  final String userUuid;
}

final class _ConfirmEmails implements UserEvent {
  const _ConfirmEmails(this.users);

  final List<User> users;
}

final class _ForceConfirmEmail implements UserEvent {
  const _ForceConfirmEmail(this.user);

  final User user;
}
