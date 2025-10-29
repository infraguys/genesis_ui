import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/permissions/permission_names/permission_names.dart';

final class AuthSession {
  AuthSession({
    required this.user,
    required this.permissionNames,
    required this.refreshToken,
    this.scope = '',
  });

  final User user;
  final PermissionNames permissionNames;
  final String refreshToken;
  final String scope;
}
