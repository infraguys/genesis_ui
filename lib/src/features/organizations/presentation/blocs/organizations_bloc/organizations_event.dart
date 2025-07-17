part of 'organizations_bloc.dart';

sealed class OrganizationsEvent {
  factory OrganizationsEvent.getOrganizationsByUser(String userUuid) = _GetOrganizationsByUser;
}

final class _GetOrganizationsByUser implements OrganizationsEvent {
  _GetOrganizationsByUser(this.userUuid);

  final String userUuid;
}
