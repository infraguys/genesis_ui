import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

final class DeleteOrganizationReq {
  DeleteOrganizationReq(this._id);

  final OrganizationID _id;

  String toPath() => OrganizationsEndpoints.deleteOrganization(_id);
}
