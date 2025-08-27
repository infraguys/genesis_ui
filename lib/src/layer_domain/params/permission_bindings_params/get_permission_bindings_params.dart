final class GetPermissionBindingsParams {
  const GetPermissionBindingsParams({
    this.permission,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  final String? permission;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
