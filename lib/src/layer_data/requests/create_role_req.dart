import 'package:genesis/src/core/interfaces/i_req.dart';
import 'package:genesis/src/layer_domain/params/create_role_params.dart';

final class CreateRoleReq implements IReq {
  CreateRoleReq(this._params);

  final CreateRoleParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': _params.description,
    };
  }
}
