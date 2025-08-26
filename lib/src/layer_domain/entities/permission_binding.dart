class PermissionBinding {
  PermissionBinding({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.permission,
    this.projectId,
  });

  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? projectId;
  final String role;
  final String permission;
}
