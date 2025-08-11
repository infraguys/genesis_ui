part of 'organizations_selection_bloc.dart';

sealed class OrganizationsSelectionEvent {
  factory OrganizationsSelectionEvent.toggleOrganization(Organization organization) = _ToggleOrganization;

  factory OrganizationsSelectionEvent.selectAll(List<Organization> organizations) = _SelectAll;

  factory OrganizationsSelectionEvent.clearSelection() = _ClearSelection;
}

final class _ToggleOrganization implements OrganizationsSelectionEvent {
  _ToggleOrganization(this.organization);

  final Organization organization;
}

final class _SelectAll implements OrganizationsSelectionEvent {
  _SelectAll(this.organizations);

  final List<Organization> organizations;
}

final class _ClearSelection implements OrganizationsSelectionEvent {}
