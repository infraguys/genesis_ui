import 'package:genesis/src/features/common/shared_entities/user.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';

abstract interface class IUsersRepository {
  Future<List<User>> getUsers();

  Future<User> createUser(CreateUserParams params);

  Future<User> updateUser(UpdateUserParams params);

  Future<void> deleteUser(String userUuid);

  Future<User> changeUserPassword(ChangeUserPasswordParams params);

  Future<User> resetUserPassword();

  Future<User> confirmEmail();

  Future<User> getUser();
}
