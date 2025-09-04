final class GetProjectsParams {
  const GetProjectsParams({
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.organization,
  });

  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? organization;
}
