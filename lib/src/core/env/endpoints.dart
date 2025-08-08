abstract class RolesEndpoints {
  static const String getRoles = '/iam/roles/';
  static const String createRole = '/iam/roles/';
  static const String getRole = '/iam/roles/:uuid';
  static const String editRole = '/iam/roles/:uuid';
  static const String deleteRole = '/iam/roles/:uuid';
}

abstract class PermissionsEndpoints {
  static const String getPermissions = '/iam/permissions/';
  static const String createPermission = '/iam/permissions/';
  static const String getPermission = '/iam/permissions/:uuid';
  static const String editPermission = '/iam/permissions/:uuid';
  static const String deletePermission = '/iam/permissions/:uuid';
}

abstract class OrganizationsEndpoints {
  static const String getOrganizations = '/iam/organizations/';
  static const String createOrganization = '/iam/organizations/';
  static const String getOrganization = '/iam/organizations/:uuid';
  static const String editOrganization = '/iam/organizations/:uuid';
  static const String deleteOrganization = '/iam/organizations/:uuid';
}

abstract class ProjectsEndpoints {
  static const String getProjects = '/iam/projects/';
  static const String createProject = '/iam/projects/';
  static const String getProject = '/iam/projects/:uuid';
  static const String editProject = '/iam/projects/:uuid';
  static const String deleteProject = '/iam/projects/:uuid';
}

abstract class RoleBindingsEndpoints {
  static const String getRoleBindings = '/iam/role_bindings/';
  static const String createRoleBinding = '/iam/role_bindings/';
  static const String getRoleBinding = '/iam/role_bindings/:uuid';
  static const String editRoleBinding = '/iam/role_bindings/:uuid';
  static const String deleteRoleBinding = '/iam/role_bindings/:uuid';
}
