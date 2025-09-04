

abstract class PermissionsEndpoints {
  static const _permissions = '/iam/permissions/';
  static const _permission = '/iam/permissions/:uuid';

  static String getPermissions() => _permissions;

  static String createPermission() => _permissions;

  static String getPermission(String uuid) => _permission.fillUuid(uuid);

  static String updatePermission(String uuid) => _permission.fillUuid(uuid);

  static String deletePermission(String uuid) => _permission.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
