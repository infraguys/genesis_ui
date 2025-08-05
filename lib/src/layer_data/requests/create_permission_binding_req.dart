final class CreatePermissionBindingReq {
  CreatePermissionBindingReq({required String permissionUuid, required String roleUuid})
    : _roleUuid = roleUuid,
      _permissionUuid = permissionUuid;

  final String _roleUuid;
  final String? _permissionUuid;

  Map<String, dynamic> toJson() {
    return {
      'role': '/v1/iam/roles/$_roleUuid',
      'permission': '/v1/iam/permissions/$_permissionUuid',
    };
  }
}
