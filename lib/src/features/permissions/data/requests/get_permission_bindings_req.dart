import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permission_bindings_params.dart';

final class GetPermissionBindingsReq {
  GetPermissionBindingsReq(this._params);

  final GetPermissionBindingsParams _params;

  Map<String, dynamic> toQuery() {
    return {
      'role': ?_params.roleUUID,
      'permission': ?_params.permission,
      'created_at': ?_params.createdAt,
      'updated_at': ?_params.updatedAt,
    };
  }

  String toPath() {
    return PermissionBindingsEndpoints.items().fullPath;
  }
}
