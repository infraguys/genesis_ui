part of 'permission_names.dart';

extension type ProjectNames(Set<String> _set) implements PermissionNames {
  bool get canReadAll => _set.contains('iam.organization.read_all') || isAdmin;

  bool get canDeleteAll => _set.contains('iam.project.delete_all') || isAdmin;

  bool get canWriteAll => _set.contains('iam.project.write_all') || isAdmin;

  bool get canListAll => _set.contains('iam.project.list_all') || isAdmin;
}
