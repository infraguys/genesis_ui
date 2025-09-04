part of 'organizations_selection_bloc.dart';

sealed class OrganizationsSelectionEvent {
  factory OrganizationsSelectionEvent.toggle(Organization organization) = _Toggle;

  factory OrganizationsSelectionEvent.toggleAll(List<Organization> organizations) = _ToggleAll;

  factory OrganizationsSelectionEvent.setCheckedFromResponse(
    Project project, {
    required List<Organization> organizations,
  }) = _SetCheckedFromResponse;

  factory OrganizationsSelectionEvent.clear() = _Clear;
}

final class _Toggle implements OrganizationsSelectionEvent {
  _Toggle(this.organization);

  final Organization organization;
}

final class _ToggleAll implements OrganizationsSelectionEvent {
  _ToggleAll(this.organizations);

  final List<Organization> organizations;
}

final class _SetCheckedFromResponse implements OrganizationsSelectionEvent {
  _SetCheckedFromResponse(this.project, {required this.organizations});

  final Project project;
  final List<Organization> organizations;
}

final class _Clear implements OrganizationsSelectionEvent {}
