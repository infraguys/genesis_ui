part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizations() = _GetOrganizations;

  factory OrganizationsEvent.deleteOrganizations(List<Organization> organizations) = _DeleteOrganizations;
}

final class _GetOrganizations implements OrganizationsEvent {}

final class _DeleteOrganizations implements OrganizationsEvent {
  _DeleteOrganizations(this.organizations);

  final List<Organization> organizations;
}
