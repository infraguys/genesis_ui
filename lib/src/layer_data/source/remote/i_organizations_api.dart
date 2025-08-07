import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/organizations/create_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organizations_req.dart';

abstract interface class IOrganizationsApi {
  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req);

  Future<OrganizationDto> createOrganization(CreateOrganizationReq req);

  Future<OrganizationDto> updateOrganization();

  Future<void> deleteOrganization(String uuid);

  Future<OrganizationDto> getOrganizationByUuid(String uuid);

  Future<List<OrganizationDto>> getOrganizationByUser(String userUuid);
}
