import 'package:genesis/src/core/env/env.dart';

abstract class RoleBindingsEndpoints {
  static const String _roleBindings = '/${Env.versionApi}/iam/role_bindings/';
  static const String _roleBinding = '/${Env.versionApi}/iam/role_bindings/:uuid';

  static const String getRoleBindings = _roleBindings;
  static const String createRoleBinding = _roleBindings;
  static const String getRoleBinding = _roleBinding;
  static const String updateRoleBinding = _roleBinding;
  static const String deleteRoleBinding = _roleBinding;
}
