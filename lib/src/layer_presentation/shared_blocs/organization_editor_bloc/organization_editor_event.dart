part of 'organization_editor_bloc.dart';

sealed class OrganizationEditorEvent {
  factory OrganizationEditorEvent.createOrganization(CreateOrganizationParams params) = _CreateOrganization;

  factory OrganizationEditorEvent.editOrganization(EditOrganizationParams params) = _EditOrganization;
}

final class _CreateOrganization implements OrganizationEditorEvent {
  const _CreateOrganization(this.params);

  final CreateOrganizationParams params;
}

final class _EditOrganization implements OrganizationEditorEvent {
  const _EditOrganization(this.params);

  final EditOrganizationParams params;
}
