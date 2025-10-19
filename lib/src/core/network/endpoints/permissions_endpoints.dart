import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/features/permissions/domain/entities/permission.dart';

abstract class PermissionsEndpoints {
  static const _permissions = '${Env.apiPrefix}/${Env.versionApi}/iam/permissions/';
  static const _permission = '/$_permissions:id';

  static String getPermissions() => _permissions;

  static String createPermission() => _permissions;

  static String getPermission(PermissionID id) => _permission.fillUuid(id);

  static String updatePermission(PermissionID id) => _permission.fillUuid(id);

  static String deletePermission(PermissionID id) => _permission.fillUuid(id);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(PermissionID id) => replaceFirst(':id', id.value);
}
