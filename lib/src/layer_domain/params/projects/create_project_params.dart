final class CreateProjectParams {
  const CreateProjectParams({
    required this.name,
    required this.description,
    required this.organizationUuid,
  });

  final String name;
  final String? description;
  final String organizationUuid;
}
