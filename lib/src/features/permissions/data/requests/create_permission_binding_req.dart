import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/create_permission_binding_params.dart';

final class CreatePermissionBindingReq {
  CreatePermissionBindingReq(this._params);

  final CreatePermissionBindingParams _params;

  Map<String, dynamic> toJson() {
    return {
      'role': RolesEndpoints.item(_params.roleUUID).relativePath,
      'permission': PermissionsEndpoints.item(_params.permissionUUID).relativePath,
    };
  }

  String toPath() {
    return PermissionBindingsEndpoints.items().fullPath;
  }
}
