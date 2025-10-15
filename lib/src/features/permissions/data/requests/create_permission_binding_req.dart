import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/create_permission_binding_params.dart';

final class CreatePermissionBindingReq implements JsonEncodable, PathEncodable {
  CreatePermissionBindingReq(this._params);

  final CreatePermissionBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'role': RolesEndpoints.getRole(_params.roleUUID).replaceFirst('${Env.apiPrefix}/', ''),
      'permission': PermissionsEndpoints.getPermission(_params.permissionUUID).replaceFirst('${Env.apiPrefix}/', ''),
    };
  }

  @override
  String toPath() {
    return PermissionBindingsEndpoints.createPermissionBinding();
  }
}
