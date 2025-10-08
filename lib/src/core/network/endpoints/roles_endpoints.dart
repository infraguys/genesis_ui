import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/role.dart';

abstract class RolesEndpoints {
  static const _roles = '/${Env.versionApi}/iam/roles/';
  static const _role = '$_roles:uuid';

  static String getRoles() => _roles;

  static String createRole() => _roles;

  static String getRole(RoleUUID uuid) => _role.fillUuid(uuid);

  static String updateRole(RoleUUID uuid) => _role.fillUuid(uuid);

  static String deleteRole(RoleUUID uuid) => _role.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(RoleUUID uuid) => replaceFirst(':uuid', uuid.value);
}
