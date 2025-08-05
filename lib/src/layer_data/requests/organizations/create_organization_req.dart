import 'package:genesis/src/layer_domain/params/create_organization_params.dart';

final class CreateOrganizationReq {
  CreateOrganizationReq(this._params);

  final CreateOrganizationParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }
}
