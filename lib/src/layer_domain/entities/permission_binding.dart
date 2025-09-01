class PermissionBinding {
  PermissionBinding({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.roleUUID,
    required this.permissionUUID,
  });

  final String uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roleUUID;
  final String permissionUUID;
}
