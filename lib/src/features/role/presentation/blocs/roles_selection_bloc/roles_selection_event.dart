part of 'roles_selection_bloc.dart';

sealed class RolesSelectionEvent {
  factory RolesSelectionEvent.toggleRole(Role role) = _ToggleRole;

  factory RolesSelectionEvent.selectAll(List<Role> roles) = _SelectAll;
}

class _ToggleRole implements RolesSelectionEvent {
  _ToggleRole(this.role);

  final Role role;
}

class _SelectAll implements RolesSelectionEvent {
  _SelectAll(this.roles);

  final List<Role> roles;
}
