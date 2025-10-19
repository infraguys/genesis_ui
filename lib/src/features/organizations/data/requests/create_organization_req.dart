import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';

final class CreateOrganizationReq {
  CreateOrganizationReq(this._params);

  final CreateOrganizationParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  String toPath() => OrganizationsEndpoints.createOrganization();
}
