class Organization {
  Organization({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final String uuid;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrganizationStatus status;
}

enum OrganizationStatus { active }
