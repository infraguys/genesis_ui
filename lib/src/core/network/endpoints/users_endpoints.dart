

abstract class UsersEndpoints {
  static const _users = '/iam/users/';
  static const _user = '/iam/users/:uuid';

  static String getUsers() => _users;

  static String createUser() => _users;

  static String getUser(String uuid) => _user.fillUuid(uuid);

  static String updateUser(String uuid) => _user.fillUuid(uuid);

  static String deleteUser(String uuid) => _user.fillUuid(uuid);

  static String changeUserPassword(String uuid) => '$_user/actions/change_password/invoke'.fillUuid(uuid);

  static String confirmUserEmail(String uuid) => '$_user/actions/confirm_email/invoke'.fillUuid(uuid);

  static String forceConfirmUserEmail(String uuid) => '$_user/actions/force_confirm_email/invoke'.fillUuid(uuid);
}

// ignore: camel_case_extensions
extension _ on String {
  String fillUuid(String uuid) => replaceFirst(':uuid', uuid);
}
