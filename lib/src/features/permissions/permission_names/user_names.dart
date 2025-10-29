part of 'permission_names.dart';

extension type UserNames(Set<String> _set) implements PermissionNames {
  bool get canWriteAll => _set.contains('iam.user.write_all') || isAdmin;

  bool get canReadAll => _set.contains('iam.user.read_all') || isAdmin;

  bool get canListAll => _set.contains('iam.user.list') || isAdmin;

  bool get canDeleteOwn => _set.contains('iam.user.delete');

  bool get canDeleteAll => _set.contains('iam.user.delete_all') || isAdmin;
}
