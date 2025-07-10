import 'package:genesis/src/features/common/shared_entities/user.dart';

abstract interface class IUsersRepository {
  Future<List<User>> getUsers();
}
