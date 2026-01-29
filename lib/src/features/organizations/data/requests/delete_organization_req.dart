import 'package:genesis/src/core/interfaces/i_request.dart';
import 'package:genesis/src/core/network/endpoints/organizations_endpoints.dart';
import 'package:genesis/src/features/organizations/domain/entities/organization.dart';

final class DeleteOrganizationReq extends IRequest {
  const DeleteOrganizationReq(this._id);

  final OrganizationID _id;

  @override
  String get path {
    return OrganizationsEndpoints.item(_id).fullPath;
  }
}
