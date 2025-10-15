part of 'permission_names.dart';

extension type RoleNames(Set<String> _set) implements PermissionNames {
  bool get canRead => _set.contains('iam.role.read') || isAdmin;

  bool get canDelete => _set.contains('iam.role.delete') || isAdmin;

  bool get canCreate => _set.contains('iam.role.create') || isAdmin;

  bool get canWrite => _set.contains('iam.role.write') || isAdmin;
}
