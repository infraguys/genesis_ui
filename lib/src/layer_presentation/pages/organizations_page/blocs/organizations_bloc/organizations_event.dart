part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizationsByUser(String userUuid) = _GetOrganizationsByUser;

  factory OrganizationsEvent.getOrganizations() = _GetOrganizations;
}

final class _GetOrganizations implements OrganizationsEvent {}

final class _GetOrganizationsByUser implements OrganizationsEvent {
  _GetOrganizationsByUser(this.userUuid);

  final String userUuid;
}
