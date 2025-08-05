part of 'organization_editor_bloc.dart';

sealed class OrganizationEditorEvent {
  factory OrganizationEditorEvent.createOrganization(CreateOrganizationParams params) = _CreateOrganization;
}

final class _CreateOrganization implements OrganizationEditorEvent {
  const _CreateOrganization(this.params);

  final CreateOrganizationParams params;
}
