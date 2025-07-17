import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/data/dtos/organization_dto.dart';

abstract interface class IOrganizationsApi {
  Future<List<Organization>> getOrganizations();

  Future<Organization> createOrganization();

  Future<Organization> updateOrganization();

  Future<void> deleteOrganization(String uuid);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<OrganizationDto>> getOrganizationByUser(String userUuid);
}
