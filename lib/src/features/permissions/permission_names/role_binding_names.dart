part of 'permission_names.dart';

extension type RoleBindingNames(Set<String> _set) implements PermissionNames {
  bool get canCreate => _set.contains('iam.role_binding.create') || isAdmin;

  bool get canUpdate => _set.contains('iam.role_binding.update') || isAdmin;

  bool get canRead => _set.contains('iam.role_binding.read') || isAdmin;

  bool get canDelete => _set.contains('iam.role_binding.delete') || isAdmin;
}
