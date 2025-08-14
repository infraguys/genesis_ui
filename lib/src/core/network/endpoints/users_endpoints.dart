import 'package:genesis/src/core/env/env.dart';

abstract class UsersEndpoints {
  static const String _users = '/${Env.versionApi}/iam/users/';
  static const String _user = '/${Env.versionApi}/iam/users/:uuid';

  static const String getUsers = _users;
  static const String createUser = _users;
  static const String getUser = _user;
  static const String updateUser = _user;
  static const String deleteUser = _user;
  static const String changeUserPassword = '$_user/actions/change_password/invoke';

  static String confirmUserEmail(String userUuid) {
    return '$_user/actions/confirm_email/invoke'.replaceFirst(':uuid', userUuid);
  }
}
