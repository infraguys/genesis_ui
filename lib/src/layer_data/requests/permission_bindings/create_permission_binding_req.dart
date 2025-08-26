import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/layer_domain/params/permission_bindings_params/create_permission_binding_params.dart';

final class CreatePermissionBindingReq implements JsonEncodable, PathEncodable {
  CreatePermissionBindingReq(this._params);

  final CreatePermissionBindingParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'role': RolesEndpoints.getRole(_params.roleUuid),
      'permission': PermissionsEndpoints.getPermission(_params.permissionUuid),
    };
  }

  @override
  String toPath() {
    return PermissionBindingsEndpoints.createPermissionBinding();
  }
}
