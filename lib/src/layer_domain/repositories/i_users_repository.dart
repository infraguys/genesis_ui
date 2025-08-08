import 'package:genesis/src/layer_domain/entities/user.dart';
import 'package:genesis/src/layer_domain/params/users/change_user_password_params.dart';
import 'package:genesis/src/layer_domain/params/users/create_user_params.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';

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
