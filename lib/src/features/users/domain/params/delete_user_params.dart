import 'package:genesis/src/features/users/domain/entities/user.dart';

final class DeleteUserParams {
  DeleteUserParams(this.id);

  final UserID id;
}
