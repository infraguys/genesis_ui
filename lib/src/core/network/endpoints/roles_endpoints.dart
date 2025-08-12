import 'package:genesis/src/core/env/env.dart';

abstract class RolesEndpoints {
  static const _roles = '/${Env.versionApi}/iam/roles/';
  static const _role = '/${Env.versionApi}/iam/roles/:uuid';

  static const String getRoles = _roles;
  static const String createRole = _roles;
  static const String getRole = _role;
  static const String updateRole = _role;
  static const String deleteRole = _role;
}
