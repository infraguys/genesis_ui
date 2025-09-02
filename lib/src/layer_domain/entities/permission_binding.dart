import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

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
  final RoleUUID roleUUID;
  final PermissionUUID permissionUUID;
}

extension type PermissionBindingUUID(String value) {
  bool isEqualTo(PermissionBindingUUID other) => value == other.value;
}
