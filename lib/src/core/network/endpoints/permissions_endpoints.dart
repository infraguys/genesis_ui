import 'package:genesis/src/core/env/env.dart';

abstract class PermissionsEndpoints {
  static const _permissions = '/${Env.versionApi}/iam/permissions/';
  static const _permission = '/${Env.versionApi}/iam/permissions/:uuid';

  static const String getPermissions = _permissions;
  static const String createPermission = _permissions;
  static const String getPermission = _permission;
  static const String updatePermission = _permission;
  static const String deletePermission = _permission;
}
