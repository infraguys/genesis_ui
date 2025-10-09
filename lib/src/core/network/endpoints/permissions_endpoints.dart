import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/permission.dart';

abstract class PermissionsEndpoints {
  static const _permissions = '${Env.apiPrefix}/${Env.versionApi}/iam/permissions/';
  static const _permission = '/$_permissions:uuid';

  static String getPermissions() => _permissions;

  static String createPermission() => _permissions;

  static String getPermission(PermissionUUID uuid) => _permission.fillUuid(uuid);

  static String updatePermission(PermissionUUID uuid) => _permission.fillUuid(uuid);

  static String deletePermission(PermissionUUID uuid) => _permission.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(PermissionUUID uuid) => replaceFirst(':uuid', uuid.value);
}
