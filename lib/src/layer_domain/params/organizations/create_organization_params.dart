final class CreateOrganizationParams {
  const CreateOrganizationParams({
    required this.name,
    this.description,
    this.info,
  });

  final String name;
  final String? description;
  final Map<String, dynamic>? info;
}
