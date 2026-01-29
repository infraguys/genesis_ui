import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/permissions_endpoints.dart';
import 'package:genesis/src/core/network/endpoints/roles_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/create_permission_binding_params.dart';

final class CreatePermissionBindingReq extends IRequest {
  const CreatePermissionBindingReq(this._params);

  final CreatePermissionBindingParams _params;

  @override
  Map<String, dynamic> get body {
    return {
      'role': RolesEndpoints.item(_params.roleID).relativePath,
      'permission': PermissionsEndpoints.item(_params.permissionID).relativePath,
    };
  }

  @override
  String get path {
    return PermissionBindingsEndpoints.items().fullPath;
  }
}
