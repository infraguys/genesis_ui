abstract interface class IPermissionBindingsApi {
  Future<void> createPermissionBinding(String role, String permissionUuid);
}
