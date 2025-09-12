import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

final class DeleteOrganizationReq implements PathEncodable {
  DeleteOrganizationReq(this._uuid);

  final OrganizationUUID _uuid;

  @override
  String toPath() {
    return OrganizationsEndpoints.deleteOrganization(_uuid);
  }
}
