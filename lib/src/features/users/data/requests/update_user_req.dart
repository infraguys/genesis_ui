import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/update_user_params.dart';

extension UpdateUserParamsX on UpdateUserParams {
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'description': description,
      'first_name': firstName,
      'last_name': lastName,
      'surname': surname,
      'phone': phone,
      'email': email,
    };
  }

  String toPath() => UsersEndpoints.updateUser(id);
}
