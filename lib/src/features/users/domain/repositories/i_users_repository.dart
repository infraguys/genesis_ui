import 'package:genesis/src/features/shared/user.dart';

abstract interface class IUsersRepository {
  Future<List<User>> getUsers();

  Future<User> getUser();

  Future<User> createUser();

  Future<User> updateUser();

  Future<User> deleteUser();

  Future<User> changeUserPassword();

  Future<User> resetUserPassword();

  Future<User> confirmEmail();
}
