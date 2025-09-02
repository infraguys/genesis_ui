import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/organizations/create_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/delete_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/edit_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organizations_req.dart';

abstract interface class IOrganizationsApi {
  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req);

  Future<OrganizationDto> getOrganization(GetOrganizationReq req);

  Future<OrganizationDto> createOrganization(CreateOrganizationReq req);

  Future<OrganizationDto> editOrganization(UpdateOrganizationReq req);

  Future<void> deleteOrganization(DeleteOrganizationReq req);

  Future<OrganizationDto> getOrganizationByUuid(String uuid);
}
