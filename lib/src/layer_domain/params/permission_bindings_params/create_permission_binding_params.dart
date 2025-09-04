import 'package:genesis/src/layer_domain/entities/permission.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

final class CreatePermissionBindingParams {
  const CreatePermissionBindingParams({
    required this.permissionUUID,
    required this.roleUUID,
  });

  final PermissionUUID permissionUUID;
  final RoleUUID roleUUID;
}
