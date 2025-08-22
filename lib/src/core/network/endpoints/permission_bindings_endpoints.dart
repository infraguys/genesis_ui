import 'package:genesis/src/core/env/env.dart';

abstract class PermissionBindingsEndpoints {
  static const String _permissionBindings = '/${Env.versionApi}/iam/permission_bindings/';
  static const String _permissionBinding = '/${Env.versionApi}/iam/permission_bindings/:uuid';

  static String getPermissionBindings() => _permissionBindings;

  static String createPermissionBinding() => _permissionBindings;

  static String getPermissionBinding(String uuid) => _permissionBinding.fillUuid(uuid);

  static String updateRoleBinding(String uuid) => _permissionBinding.fillUuid(uuid);

  static String deleteRoleBinding(String uuid) => _permissionBinding.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
