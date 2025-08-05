part of 'organization_editor_bloc.dart';

sealed class OrganizationEditorEvent {
  factory OrganizationEditorEvent.createOrganization({
    required String name,
    String? description,
  }) = _CreateOrganization;
}

final class _CreateOrganization implements OrganizationEditorEvent {
  const _CreateOrganization({required this.name, this.description});

  final String name;
  final String? description;
}
