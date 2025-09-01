import 'package:genesis/src/layer_domain/entities/permission.dart';

final class CreatePermissionBindingParams {
  const CreatePermissionBindingParams({
    required this.permissionUUID,
    required this.roleUuid,
  });

  final PermissionUUID permissionUUID;
  final String roleUuid;
}
