import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

class PermissionBinding {
  PermissionBinding({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.roleLink,
    required this.permissionLink,
  });

  RoleUUID get roleId => RoleUUID(roleLink.split('/').last);

  PermissionID get permissionId => PermissionID(permissionLink.split('/').last);

  final PermissionBindingID id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roleLink;
  final String permissionLink;
}

extension type PermissionBindingID(String value) {
  bool isEqualTo(PermissionBindingID other) => value == other.value;
}
