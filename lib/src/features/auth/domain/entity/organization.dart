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
  final String createdAt;
  final String updatedAt;
  final String status;
}

//{
//     "uuid": "00000000-0000-0000-0000-000000000000",
//     "name": "admin",
//     "description": "Admin Organization",
//     "created_at": "2025-05-15 11:01:57.056852",
//     "updated_at": "2025-05-15 11:01:57.056852",
//     "status": "ACTIVE",
//     "info": "{}"
//     },
