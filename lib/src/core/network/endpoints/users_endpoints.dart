import 'package:genesis/src/core/env/env.dart';

abstract class UsersEndpoints {
  static const String _users = '/${Env.versionApi}/iam/users/';
  static const String _user = '/${Env.versionApi}/iam/users/:uuid';

  static String getUsers() => _users;

  static String createUser() => _users;

  static String getUser(String uuid) => _user.fillUuid(uuid);

  static String updateUser(String uuid) => _user.fillUuid(uuid);

  static String deleteUser(String uuid) => _user.fillUuid(uuid);

  static String changeUserPassword(String uuid) => '$_user/actions/change_password/invoke'.fillUuid(uuid);

  static String confirmUserEmail(String uuid) => '$_user/actions/confirm_email/invoke'.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
