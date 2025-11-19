part of 'organization_bloc.dart';

sealed class OrganizationEvent {
  factory OrganizationEvent.create(CreateOrganizationParams params) = _Create;

  factory OrganizationEvent.get(OrganizationID id) = _Get;

  factory OrganizationEvent.update(UpdateOrganizationParams params) = _Update;

  factory OrganizationEvent.delete(Organization organization) = _Delete;
}

final class _Get implements OrganizationEvent {
  const _Get(this.id);

  final OrganizationID id;
}

final class _Create implements OrganizationEvent {
  const _Create(this.params);

  final CreateOrganizationParams params;
}

final class _Update implements OrganizationEvent {
  const _Update(this.params);

  final UpdateOrganizationParams params;
}

final class _Delete implements OrganizationEvent {
  const _Delete(this.organization);

  final Organization organization;
}
