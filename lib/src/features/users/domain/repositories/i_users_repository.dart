import 'package:genesis/src/features/users/domain/entities/user.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';
import 'package:genesis/src/features/users/domain/params/confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';
import 'package:genesis/src/features/users/domain/params/delete_user_params.dart';
import 'package:genesis/src/features/users/domain/params/force_confirm_email_params.dart';
import 'package:genesis/src/features/users/domain/params/get_user_params.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';

abstract interface class IUsersRepository {
  Future<List<User>> getUsers(GetUsersParams params);

  Future<User> createUser(CreateUserParams params);

  Future<User> updateUser(UpdateUserParams params);

  Future<void> deleteUser(DeleteUserParams params);

  Future<User> changeUserPassword(ChangeUserPasswordParams params);

  Future<User> resetUserPassword();

  Future<User> confirmEmail(ConfirmEmailParams params);

  Future<User> forceConfirmEmail(ForceConfirmEmailParams params);

  Future<User> getUser(GetUserParams params);
}
