import 'package:genesis/src/core/env/env.dart';

abstract class RolesEndpoints {
  static const _roles = '/${Env.versionApi}/iam/roles/';
  static const _role = '/${Env.versionApi}/iam/roles/:uuid';

  static String getRoles() => _roles;

  static String createRole() => _roles;

  static String getRole(String uuid) => _role.fillUuid(uuid);

  static String updateRole(String uuid) => _role.fillUuid(uuid);

  static String deleteRole(String uuid) => _role.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
