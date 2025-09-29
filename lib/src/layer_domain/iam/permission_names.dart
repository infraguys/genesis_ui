extension type PermissionNames(Set<String> _set) {
  /// Namespace: iam.users
  UserPermissions get users => UserPermissions(_set);

  /// Namespace: iam.organization
  OrganizationPermissions get organizations => OrganizationPermissions(_set);

  /// Namespace: iam.nodes
  NodePermissions get nodes => NodePermissions(_set);

  /// Namespace: iam.roles
  RolePermissions get roles => RolePermissions(_set);

  /// Namespace: iam.projects
  ProjectPermissions get projects => ProjectPermissions(_set);

  /// Namespace: iam.role_bindings
  RoleBindingPermissions get roleBindings => RoleBindingPermissions(_set);

  bool get isAdmin => _set.contains('*.*.*');
}

extension type OrganizationPermissions(Set<String> _set) implements PermissionNames {
  bool get canReadAll => _set.contains('iam.organization.read_all') || isAdmin;

  bool get canWriteAll => _set.contains('iam.organization.write_all') || isAdmin;

  bool get canDeleteAll => _set.contains('iam.organization.delete_all') || isAdmin;

  bool get canCreate => _set.contains('iam.organization.create') || isAdmin;

  bool get canDelete => _set.contains('iam.organization.delete') || isAdmin;

  bool get canDeleteAny => canDelete || canDeleteAll;
}
extension type UserPermissions(Set<String> _set) implements PermissionNames {
  bool get canWriteAll => _set.contains('iam.user.write_all') || isAdmin;

  bool get canReadAll => _set.contains('iam.user.read_all') || isAdmin;

  bool get canListAll => _set.contains('iam.user.list') || isAdmin;

  bool get canDeleteOwn => _set.contains('iam.user.delete');

  bool get canDeleteAll => _set.contains('iam.user.delete_all') || isAdmin;
}

extension type RoleBindingPermissions(Set<String> _set) implements PermissionNames {
  bool get canCreate => _set.contains('iam.role_binding.create') || isAdmin;

  bool get canUpdate => _set.contains('iam.role_binding.update') || isAdmin;

  bool get canRead => _set.contains('iam.role_binding.read') || isAdmin;

  bool get canDelete => _set.contains('iam.role_binding.delete') || isAdmin;
}

extension type NodePermissions(Set<String> _set) {}
extension type RolePermissions(Set<String> _set) {}

extension type ProjectPermissions(Set<String> _set) implements PermissionNames {
  bool get canReadAll => _set.contains('iam.organization.read_all') || isAdmin;

  bool get canDeleteAll => _set.contains('iam.project.delete_all') || isAdmin;

  bool get canWriteAll => _set.contains('iam.project.write_all') || isAdmin;

  bool get canListAll => _set.contains('iam.project.list_all') || isAdmin;
}
