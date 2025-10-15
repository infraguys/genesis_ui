import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';

final class UpdateOrganizationReq implements JsonEncodable, PathEncodable {
  UpdateOrganizationReq(this._params);

  final UpdateOrganizationParams _params;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': _params.name,
      'description': ?_params.description,
    };
  }

  @override
  String toPath() {
    return OrganizationsEndpoints.updateOrganization(_params.id);
  }
}
