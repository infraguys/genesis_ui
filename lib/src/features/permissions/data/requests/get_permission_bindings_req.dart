import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permission_bindings_params.dart';

final class GetPermissionBindingsReq implements PathEncodable, QueryEncodable {
  GetPermissionBindingsReq(this._params);

  final GetPermissionBindingsParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'role': ?_params.roleUUID,
      'permission': ?_params.permission,
      'created_at': ?_params.createdAt,
      'updated_at': ?_params.updatedAt,
    };
  }

  @override
  String toPath() {
    return PermissionBindingsEndpoints.getPermissionBindings();
  }
}
