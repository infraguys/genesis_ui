import 'package:genesis/src/core/env/env.dart';

abstract class UsersEndpoints {
  static const String _users = '/${Env.versionApi}/iam/users/';
  static const String _user = '/${Env.versionApi}/iam/users/:uuid';

  static const String getUsers = _users;
  static const String createUser = _users;
  static const String getUser = _user;
  static const String updateUser = _user;
  static const String deleteUser = _user;
  static const String changeUserPassword = '$_user/actions/change_password/invoke';
  static const String confirmUserEmail = '$_user/actions/confirm_email/invoke';
}

abstract class RolesEndpoints {
  static const _roles = '/${Env.versionApi}/iam/roles/';
  static const _role = '/${Env.versionApi}/iam/roles/:uuid';

  static const String getRoles = _roles;
  static const String createRole = _roles;
  static const String getRole = _role;
  static const String updateRole = _role;
  static const String deleteRole = _role;
}

abstract class PermissionsEndpoints {
  static const _permissions = '/${Env.versionApi}/iam/permissions/';
  static const _permission = '/${Env.versionApi}/iam/permissions/:uuid';

  static const String getPermissions = _permissions;
  static const String createPermission = _permissions;
  static const String getPermission = _permission;
  static const String updatePermission = _permission;
  static const String deletePermission = _permission;
}

abstract class OrganizationsEndpoints {
  static const String _organizations = '/${Env.versionApi}/iam/organizations/';
  static const String _organization = '/${Env.versionApi}/iam/organizations/:uuid';

  static const String getOrganizations = _organizations;
  static const String createOrganization = _organizations;
  static const String getOrganization = _organization;
  static const String updateOrganization = _organization;
  static const String deleteOrganization = _organization;
}

abstract class ProjectsEndpoints {
  static const String _projects = '/${Env.versionApi}/iam/projects/';
  static const String _project = '/${Env.versionApi}/iam/projects/:uuid';

  static const String getProjects = _projects;
  static const String createProject = _projects;
  static const String getProject = _project;
  static const String updateProject = _project;
  static const String deleteProject = _project;
}

abstract class RoleBindingsEndpoints {
  static const String _roleBindings = '/${Env.versionApi}/iam/role_bindings/';
  static const String _roleBinding = '/${Env.versionApi}/iam/role_bindings/:uuid';

  static const String getRoleBindings = _roleBindings;
  static const String createRoleBinding = _roleBindings;
  static const String getRoleBinding = _roleBinding;
  static const String updateRoleBinding = _roleBinding;
  static const String deleteRoleBinding = _roleBinding;
}
