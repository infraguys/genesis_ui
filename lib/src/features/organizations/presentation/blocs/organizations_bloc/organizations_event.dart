part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizations([GetOrganizationsParams params]) = _Get;

  factory OrganizationsEvent.deleteOrganizations(List<Organization> organizations) = _Delete;
}

final class _Get implements OrganizationsEvent {
  _Get([this.params = const GetOrganizationsParams()]);

  final GetOrganizationsParams params;
}

final class _Delete implements OrganizationsEvent {
  _Delete(this.organizations);

  final List<Organization> organizations;
}
