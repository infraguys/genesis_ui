import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/change_user_password_params.dart';

extension ChangeUserPasswordParamsX on ChangeUserPasswordParams {
  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }

  String toPath() => UsersEndpoints.changeUserPassword(id);
}
