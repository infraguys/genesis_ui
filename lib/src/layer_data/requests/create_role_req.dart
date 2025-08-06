import 'package:genesis/src/layer_domain/params/create_role_params.dart';

final class CreateRoleReq {
  CreateRoleReq(this._params);

  final CreateRoleParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': _params.description,
    };
  }
}
