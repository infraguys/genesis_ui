class PermissionBinding {
  PermissionBinding({
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.roleUUID,
    required this.permissionUUID,
  });

  final PermissionBindingUUID uuid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roleUUID;
  final String permissionUUID;
}

extension type PermissionBindingUUID(String value) {}
