import 'package:genesis/src/features/auth/domain/entity/user.dart';

abstract interface class IUserRepository {
  Future<User> createUser();

  Future<User> getUser();

  Future<User> updateUser();

  Future<User> deleteUser();

  Future<User> changeUserPassword();

  Future<User> resetUserPassword();

  Future<User> confirmUserEmail();

  Future<List<User>> getUsers();
}
