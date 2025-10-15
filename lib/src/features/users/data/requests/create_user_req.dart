import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/create_user_params.dart';

extension CreateUserParamsX on CreateUserParams {
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'description': ?description,
      'surname': ?surname,
      'phone': ?phone,
    };
  }

  String toPath() => UsersEndpoints.createUser();
}
