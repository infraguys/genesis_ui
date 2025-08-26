final class CreatePermissionBindingParams {
  const CreatePermissionBindingParams({
    required this.permissionUuid,
    required this.roleUuid,
  });

  final String permissionUuid;
  final String roleUuid;
}
