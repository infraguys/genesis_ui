import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';
import 'package:genesis/src/features/permissions/domain/params/get_permission_bindings_params.dart';

final class GetPermissionBindingsReq extends IRequest {
  const GetPermissionBindingsReq(this._params);

  final GetPermissionBindingsParams _params;

  @override
  Map<String, dynamic> get query {
    return {
      'role': ?_params.roleUUID,
      'permission': ?_params.permission,
      'created_at': ?_params.createdAt,
      'updated_at': ?_params.updatedAt,
    };
  }

  @override
  String get path {
    return PermissionBindingsEndpoints.items().fullPath;
  }
}
