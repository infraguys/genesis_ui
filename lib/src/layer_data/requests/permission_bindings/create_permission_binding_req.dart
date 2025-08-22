import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/permission_bindings_endpoints.dart';

final class CreatePermissionBindingReq implements JsonEncodable, PathEncodable {
  CreatePermissionBindingReq({required String permissionUuid, required String roleUuid})
    : _roleUuid = roleUuid,
      _permissionUuid = permissionUuid;

  final String _roleUuid;
  final String? _permissionUuid;

  @override
  Map<String, dynamic> toJson() {
    return {
      'role': '/v1/iam/roles/$_roleUuid',
      'permission': '/v1/iam/permissions/$_permissionUuid',
    };
  }

  @override
  String toPath() {
    return PermissionBindingsEndpoints.createPermissionBinding();
  }
}
