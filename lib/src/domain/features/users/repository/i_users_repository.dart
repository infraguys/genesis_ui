import 'package:genesis/src/domain/entities/user.dart';
import 'package:genesis/src/domain/features/users/params/create_user_params.dart';

abstract interface class IUsersRepository {
  Future<List<User>> getUsers();

  Future<User> getUser();

  Future<User> createUser(CreateUserParams params);

  Future<User> updateUser();

  Future<void> deleteUser(String userUuid);

  Future<User> changeUserPassword();

  Future<User> resetUserPassword();

  Future<User> confirmEmail();
}
