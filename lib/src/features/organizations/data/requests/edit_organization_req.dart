import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';

final class UpdateOrganizationReq {
  UpdateOrganizationReq(this._params);

  final UpdateOrganizationParams _params;

  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  String toPath() {
    return OrganizationsEndpoints.item(_params.id).fullPath;
  }
}
