import 'package:genesis/src/core/env/env.dart';

abstract class PermissionsEndpoints {
  static final _permissions = '/${Env.versionApi}/iam/permissions/';
  static final _permission = '/${Env.versionApi}/iam/permissions/:uuid';

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
