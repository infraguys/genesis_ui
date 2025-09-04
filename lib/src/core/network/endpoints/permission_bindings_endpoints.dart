

abstract class PermissionBindingsEndpoints {
  static const _permissionBindings = '/iam/permission_bindings/';
  static const _permissionBinding = '/iam/permission_bindings/:uuid';

  static String getPermissionBindings() => _permissionBindings;

  static String createPermissionBinding() => _permissionBindings;

  static String getPermissionBinding(String uuid) => _permissionBinding.fillUuid(uuid);

  static String updatePermissionBinding(String uuid) => _permissionBinding.fillUuid(uuid);

  static String deletePermissionBinding(String uuid) => _permissionBinding.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
