import 'package:genesis/src/layer_domain/entities/user.dart';

class ChangeUserPasswordParams {
  ChangeUserPasswordParams({
    required this.uuidUUID,
    required this.oldPassword,
    required this.newPassword,
  });

  final UserUUID uuidUUID;
  final String oldPassword;
  final String newPassword;
}
