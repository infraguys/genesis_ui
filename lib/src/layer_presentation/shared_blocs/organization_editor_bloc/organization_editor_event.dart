part of 'organization_editor_bloc.dart';

sealed class OrganizationEditorEvent {
  factory OrganizationEditorEvent.createOrganization(CreateOrganizationParams params) = _CreateOrganization;

  factory OrganizationEditorEvent.updateOrganization(UpdateOrganizationParams params) = _UpdateOrganization;
}

final class _CreateOrganization implements OrganizationEditorEvent {
  const _CreateOrganization(this.params);

  final CreateOrganizationParams params;
}

final class _UpdateOrganization implements OrganizationEditorEvent {
  const _UpdateOrganization(this.params);

  final UpdateOrganizationParams params;
}
