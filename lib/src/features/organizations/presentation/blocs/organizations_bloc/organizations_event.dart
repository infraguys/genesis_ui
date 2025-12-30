part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizations([
    GetOrganizationsParams params = const GetOrganizationsParams(),
  ]) => _Get(params);

  factory OrganizationsEvent.deleteOrganizations(List<Organization> organizations) = _Delete;
}

final class _Get implements OrganizationsEvent {
  _Get(this.params);

  final GetOrganizationsParams params;
}

final class _Delete implements OrganizationsEvent {
  _Delete(this.organizations);

  final List<Organization> organizations;
}
