part of 'permission_names.dart';

extension type OrganizationNames(Set<String> _set) implements PermissionNames {
  bool get canReadAll => _set.contains('iam.organization.read_all') || isAdmin;

  bool get canWriteAll => _set.contains('iam.organization.write_all') || isAdmin;

  bool get canDeleteAll => _set.contains('iam.organization.delete_all') || isAdmin;

  bool get canCreate => _set.contains('iam.organization.create') || isAdmin;

  bool get canDeleteOwn => _set.contains('iam.organization.delete') || isAdmin;
}
