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
