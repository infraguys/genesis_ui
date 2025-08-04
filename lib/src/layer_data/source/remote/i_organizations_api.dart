import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/get_organizations_req.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';

abstract interface class IOrganizationsApi {
  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req);

  Future<Organization> createOrganization();

  Future<Organization> updateOrganization();

  Future<void> deleteOrganization(String uuid);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<OrganizationDto>> getOrganizationByUser(String userUuid);
}
