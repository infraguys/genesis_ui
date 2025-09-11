final class GetExtensionsParams {
  const GetExtensionsParams({
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.version,
    this.installType,
    this.link,
  });

  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? version;
  final String? installType;
  final String? link;
}
