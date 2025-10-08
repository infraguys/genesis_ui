import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/iam/permission_names.dart';

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
