import 'package:genesis/src/features/permissions/domain/entities/permission.dart';
import 'package:genesis/src/features/roles/domain/entities/role.dart';

final class CreatePermissionBindingParams {
  const CreatePermissionBindingParams({
    required this.permissionUUID,
    required this.roleUUID,
  });

  final PermissionUUID permissionUUID;
  final RoleUUID roleUUID;
}
