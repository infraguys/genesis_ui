final class EditOrganizationParams {
  const EditOrganizationParams({
    required this.uuid,
    required this.name,
    this.description,
    this.info,
  });

  final String uuid;
  final String name;
  final String? description;
  final Map<String, dynamic>? info;
}
