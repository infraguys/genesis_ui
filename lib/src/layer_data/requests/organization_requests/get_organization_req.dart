import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

final class GetOrganizationReq implements PathEncodable {
  GetOrganizationReq(this._id);

  final OrganizationID _id;

  @override
  String toPath() {
    return OrganizationsEndpoints.getOrganization(_id);
  }
}
