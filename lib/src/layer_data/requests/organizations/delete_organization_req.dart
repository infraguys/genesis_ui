import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/layer_domain/params/organizations/delete_organization_params.dart';

final class DeleteOrganizationReq implements PathEncodable {
  DeleteOrganizationReq(this._params);

  final DeleteOrganizationParams _params;

  @override
  String toPath(String prefix) {
    return '$prefix/${_params.uuid}';
  }
}
