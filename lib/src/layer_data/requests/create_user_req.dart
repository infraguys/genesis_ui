import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/create_user_params.dart';

final class CreateUserReq implements JsonEncodable, PathEncodable {
  CreateUserReq(this._params);

  final CreateUserParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': _params.username,
      'first_name': _params.firstName,
      'last_name': _params.lastName,
      'email': _params.email,
      'password': _params.password,
      'description': ?_params.description,
      'surname': ?_params.surname,
      'phone': ?_params.phone,
    };
  }

  @override
  String toPath(String prefix) => prefix;
}
