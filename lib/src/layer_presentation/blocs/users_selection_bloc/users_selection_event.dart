part of 'users_selection_bloc.dart';

sealed class UsersSelectionEvent {
  factory UsersSelectionEvent.toggle(User user) = _Toggle;

  factory UsersSelectionEvent.toggleAll(List<User> users) = _ToggleAll;

  factory UsersSelectionEvent.clear() = _Clear;
}

final class _Toggle implements UsersSelectionEvent {
  _Toggle(this.user);

  final User user;
}

final class _ToggleAll implements UsersSelectionEvent {
  _ToggleAll(this.users);

  final List<User> users;
}

final class _Clear implements UsersSelectionEvent {}
