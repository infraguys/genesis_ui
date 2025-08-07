part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizationsByUser(String userUuid) = _GetOrganizationsByUser;

  factory OrganizationsEvent.getOrganizations() = _GetOrganizations;

  factory OrganizationsEvent.deleteOrganizations(List<DeleteOrganizationParams> organizationUuids) =
      _DeleteOrganizations;
}

final class _GetOrganizations implements OrganizationsEvent {}

final class _GetOrganizationsByUser implements OrganizationsEvent {
  _GetOrganizationsByUser(this.userUuid);

  final String userUuid;
}

final class _DeleteOrganizations implements OrganizationsEvent {
  _DeleteOrganizations(this.listOfParams);

  final List<DeleteOrganizationParams> listOfParams;
}
