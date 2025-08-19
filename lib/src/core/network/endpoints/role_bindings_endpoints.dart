import 'package:genesis/src/core/env/env.dart';

abstract class RoleBindingsEndpoints {
  static const String _roleBindings = '/${Env.versionApi}/iam/role_bindings/';
  static const String _roleBinding = '/${Env.versionApi}/iam/role_bindings/:uuid';

  static String getRoleBindings() => _roleBindings;

  static String createRoleBinding() => _roleBindings;

  static String getRoleBinding(String uuid) => _roleBinding.fillUuid(uuid);

  static String updateRoleBinding(String uuid) => _roleBinding.fillUuid(uuid);

  static String deleteRoleBinding(String uuid) => _roleBinding.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
