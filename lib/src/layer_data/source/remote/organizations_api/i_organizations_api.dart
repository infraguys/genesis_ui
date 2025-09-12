import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/create_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/delete_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/edit_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/get_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/get_organizations_req.dart';

abstract interface class IOrganizationsApi {
  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req);

  Future<OrganizationDto> getOrganization(GetOrganizationReq req);

  Future<OrganizationDto> createOrganization(CreateOrganizationReq req);

  Future<OrganizationDto> editOrganization(UpdateOrganizationReq req);

  Future<void> deleteOrganization(DeleteOrganizationReq req);
}
