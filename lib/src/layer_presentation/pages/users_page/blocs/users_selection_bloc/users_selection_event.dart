part of 'users_selection_bloc.dart';

sealed class UsersSelectionEvent {
  factory UsersSelectionEvent.toggleUser(User user) = _ToggleUser;

  factory UsersSelectionEvent.selectAll(List<User> users) = _SelectAllUsers;

  factory UsersSelectionEvent.clearSelection() = _ClearSelection;
}

final class _ToggleUser implements UsersSelectionEvent {
  _ToggleUser(this.user);

  final User user;
}

final class _SelectAllUsers implements UsersSelectionEvent {
  _SelectAllUsers(this.users);

  final List<User> users;
}

final class _ClearSelection implements UsersSelectionEvent {}
