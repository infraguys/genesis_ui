import 'package:genesis/src/features/auth/domain/entity/user.dart';
import 'package:genesis/src/features/auth/domain/params/sign_up_params.dart';

abstract interface class IUserRepository {
  Future<User> singUp(SignUpParams params);

  Future<User> getUser();

  Future<User> updateUser();

  Future<User> deleteUser();

  Future<User> changeUserPassword();

  Future<User> resetUserPassword();

  Future<User> confirmUserEmail();

  Future<List<User>> getUsers();
}
