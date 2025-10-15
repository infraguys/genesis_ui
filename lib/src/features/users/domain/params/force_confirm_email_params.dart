import 'package:genesis/src/features/users/domain/entities/user.dart';

final class ForceConfirmEmailParams {
  ForceConfirmEmailParams(this.id);

  final UserUUID id;
}
