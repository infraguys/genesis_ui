final class CreateRoleBindingParams {
  CreateRoleBindingParams({
    required this.userUuid,
    required this.roleUuid,
    this.projectUuid,
  });

  final String userUuid;
  final String roleUuid;
  final String? projectUuid;
}
