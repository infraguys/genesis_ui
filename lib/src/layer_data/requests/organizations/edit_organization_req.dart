import 'package:genesis/src/core/env/endpoints.dart';
import 'package:genesis/src/core/interfaces/json_encodable.dart';
import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/organizations/edit_organiztion_params.dart';

final class EditOrganizationReq implements JsonEncodable, PathEncodable {
  EditOrganizationReq(this._params);

  final EditOrganizationParams _params;

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
