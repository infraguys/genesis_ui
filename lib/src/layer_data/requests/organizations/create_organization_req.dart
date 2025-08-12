import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';

final class CreateOrganizationReq implements JsonEncodable, PathEncodable {
  CreateOrganizationReq(this._params);

  final CreateOrganizationParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String toPath() {
    return OrganizationsEndpoints.createOrganization;
  }
}

extension CreateOrganizationParamsX on CreateOrganizationParams {
  CreateOrganizationReq toReq() => CreateOrganizationReq(this);
}
