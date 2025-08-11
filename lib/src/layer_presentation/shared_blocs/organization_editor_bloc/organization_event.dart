part of 'organization_bloc.dart';

sealed class OrganizationEvent {
  factory OrganizationEvent.createOrganization(CreateOrganizationParams params) = _Create;

  factory OrganizationEvent.updateOrganization(UpdateOrganizationParams params) = _Update;
}

final class _Create implements OrganizationEvent {
  const _Create(this.params);

  final CreateOrganizationParams params;
}

final class _Update implements OrganizationEvent {
  const _Update(this.params);

  final UpdateOrganizationParams params;
}
