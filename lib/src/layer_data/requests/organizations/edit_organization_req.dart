import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/organizations/update_organization_params.dart';

final class EditOrganizationReq implements JsonEncodable, PathEncodable {
  EditOrganizationReq(this._params);

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
    return OrganizationsEndpoints.editOrganization.replaceFirst(':uuid', _params.uuid);
  }
}
