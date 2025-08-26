final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUuid,
    this.projectUuid,
    this.roleUuid,
    this.createdAt,
    this.updatedAt,
  });

  final String? userUuid;
  final String? projectUuid;
  final String? roleUuid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
