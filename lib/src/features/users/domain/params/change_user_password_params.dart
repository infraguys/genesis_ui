import 'package:genesis/src/features/users/domain/entities/user.dart';

final class ChangeUserPasswordParams {
  ChangeUserPasswordParams({
    required this.id,
    required this.oldPassword,
    required this.newPassword,
  });

  final UserID id;
  final String oldPassword;
  final String newPassword;
}
