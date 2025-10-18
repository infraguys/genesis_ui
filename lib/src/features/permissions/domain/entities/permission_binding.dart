import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

class PermissionBinding {
  PermissionBinding({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.roleLocation,
    required this.permissionLocation,
  });

  RoleUUID get roleId => RoleUUID(roleLocation.split('/').last);
  PermissionUUID get permissionId => PermissionUUID(permissionLocation.split('/').last);

  final PermissionBindingID id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String roleLocation;
  final String permissionLocation;
}

extension type PermissionBindingID(String value) {
  bool isEqualTo(PermissionBindingID other) => value == other.value;
}
