import 'package:genesis/src/core/interfaces/path_encodable.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

final class DeleteOrganizationReq implements PathEncodable {
  DeleteOrganizationReq(this._id);

  final OrganizationID _id;

  @override
  String toPath() {
    return OrganizationsEndpoints.deleteOrganization(_id);
  }
}
