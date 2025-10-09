import 'package:genesis/src/core/env/env.dart';
import 'package:genesis/src/layer_domain/entities/user.dart';

abstract class UsersEndpoints {
  static const _users = '${Env.apiPrefix}/${Env.versionApi}/iam/users/';
  static const _user = '/$_users:uuid';

  static String getUsers() => _users;

  static String createUser() => _users;

  static String getUser(UserUUID uuid) => _user.fillUuid(uuid);

  static String updateUser(UserUUID uuid) => _user.fillUuid(uuid);

  static String deleteUser(UserUUID uuid) => _user.fillUuid(uuid);

  static String changeUserPassword(UserUUID uuid) => '$_user/actions/change_password/invoke'.fillUuid(uuid);

  static String confirmUserEmail(UserUUID uuid) => '$_user/actions/confirm_email/invoke'.fillUuid(uuid);

  static String forceConfirmUserEmail(UserUUID uuid) => '$_user/actions/force_confirm_email/invoke'.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(UserUUID uuid) => replaceFirst(':uuid', uuid.value);
}
