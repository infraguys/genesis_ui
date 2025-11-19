part of 'roles_selection_bloc.dart';

sealed class RolesSelectionEvent {
  factory RolesSelectionEvent.toggle(Role role) = _Toggle;

  factory RolesSelectionEvent.toggleAll(List<Role> roles) = _ToggleAll;

  factory RolesSelectionEvent.clear() = _Clear;
}

final class _Toggle implements RolesSelectionEvent {
  _Toggle(this.role);

  final Role role;
}

final class _ToggleAll implements RolesSelectionEvent {
  _ToggleAll(this.roles);

  final List<Role> roles;
}

final class _Clear implements RolesSelectionEvent {}
