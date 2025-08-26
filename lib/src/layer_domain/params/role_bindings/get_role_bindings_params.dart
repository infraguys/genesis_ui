final class GetRoleBindingsParams {
  GetRoleBindingsParams({
    this.userUuid,
    this.projectUuid,
    this.roleUuid,
  });

  final String? userUuid;
  final String? projectUuid;
  final String? roleUuid;
}
