import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/users_endpoints.dart';
import 'package:genesis/src/layer_domain/params/users/update_user_params.dart';

class UpdateUserReq implements JsonEncodable, PathEncodable {
  const UpdateUserReq(this._params);

  final UpdateUserParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': ?_params.username,
      'description': ?_params.description,
      'first_name': ?_params.firstName,
      'last_name': ?_params.lastName,
      'surname': ?_params.surname,
      'phone': ?_params.phone,
      'email': ?_params.email,
    };
  }

  @override
  String toPath() => UsersEndpoints.updateUser;
}
