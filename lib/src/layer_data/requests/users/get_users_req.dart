import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/interfaces/query_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/get_users_params.dart';

final class GetUsersReq implements PathEncodable, QueryEncodable {
  const GetUsersReq(this._params);

  final GetUsersParams _params;

  @override
  Map<String, dynamic> toQuery() {
    return {
      'name': ?_params.name,
      'description': ?_params.description,
      'createdAt': ?_params.createdAt?.toIso8601String(),
      'updatedAt': ?_params.updatedAt?.toIso8601String(),
      'salt': ?_params.salt,
      'secretHash': ?_params.secretHash,
      'firstName': ?_params.firstName,
      'lastName': ?_params.lastName,
      'surname': ?_params.surname,
      'email': ?_params.email,
      'phone': ?_params.phone,
      'emailVerified': ?_params.emailVerified,
      'password': ?_params.password,
    };
  }

  @override
  String toPath() {
    return UsersEndpoints.getUsers;
  }
}
