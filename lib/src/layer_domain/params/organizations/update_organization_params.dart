final class UpdateOrganizationParams {
  const UpdateOrganizationParams({
    required this.uuid,
    this.name,
    this.description,
    this.info,
  });

  final String uuid;
  final String? name;
  final String? description;
  final Map<String, dynamic>? info;
}
