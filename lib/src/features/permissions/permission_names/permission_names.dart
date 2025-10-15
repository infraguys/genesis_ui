part 'organization_names.dart';
part 'project_names.dart';
part 'role_binding_names.dart';
part 'role_names.dart';
part 'user_names.dart';

extension type PermissionNames(Set<String> _set) {
  /// Namespace: iam.users
  UserNames get users => UserNames(_set);

  /// Namespace: iam.organization
  OrganizationNames get organizations => OrganizationNames(_set);

  /// Namespace: iam.nodes
  NodePermissions get nodes => NodePermissions(_set);

  /// Namespace: iam.roles
  RoleNames get roles => RoleNames(_set);

  /// Namespace: iam.roles_permissions
  RolePermissions get rolesPermissions => RolePermissions(_set);

  /// Namespace: iam.projects
  ProjectNames get projects => ProjectNames(_set);

  /// Namespace: iam.role_bindings
  RoleBindingNames get roleBindings => RoleBindingNames(_set);

  bool get isAdmin => _set.contains('*.*.*');
}

extension type NodePermissions(Set<String> _set) {}
extension type RolePermissions(Set<String> _set) {}
