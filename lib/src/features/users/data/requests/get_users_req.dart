import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/features/users/domain/params/get_users_params.dart';

extension GetUsersParamsX on GetUsersParams {
  Map<String, dynamic> toQuery() {
    return {
      'name': ?name,
      'description': ?description,
      'created_at': ?createdAt?.toIso8601String(),
      'updated_at': ?updatedAt?.toIso8601String(),
      'firstName': ?firstName,
      'lastName': ?lastName,
      'surname': ?surname,
      'email': ?email,
      'phone': ?phone,
      'email_verified': ?emailVerified,
      'password': ?password,
    };
  }

  String toPath() => UsersEndpoints.getUsers();
}
