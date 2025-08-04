abstract interface class IRoleBindingsApi {
  Future<void> createRoleBinding(String roleUuid, String userUuid);
}
