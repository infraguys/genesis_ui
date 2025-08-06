import 'package:genesis/src/core/interfaces/json_encodable.dart';

final class CreatePermissionBindingReq implements JsonEncodable {
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
}
