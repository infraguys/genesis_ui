import 'package:genesis/src/core/network/endpoints/endpoint.dart';
import 'package:genesis/src/features/users/domain/entities/user.dart';

abstract class UsersEndpoints {
  static Endpoint items() {
    return Endpoint.withCorePrefix('/iam/users/');
  }

  static Endpoint item(UserUUID id) {
    return Endpoint.withCorePrefix('/iam/users/$id');
  }

  static Endpoint changeUserPassword(UserUUID id) {
    return Endpoint.withCorePrefix('/iam/users/$id/actions/change_password/invoke');
  }

  static Endpoint confirmUserEmail(UserUUID id) {
    return Endpoint.withCorePrefix('/iam/users/$id/actions/confirm_email/invoke');
  }

  static Endpoint forceConfirmUserEmail(UserUUID id) {
    return Endpoint.withCorePrefix('/iam/users/$id/actions/force_confirm_email/invoke');
  }
}
