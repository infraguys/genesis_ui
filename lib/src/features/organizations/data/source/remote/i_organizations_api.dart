import 'package:genesis/src/features/common/shared_entities/organization.dart';

abstract interface class IOrganizationsApi {
  Future<List<Organization>> getOrganizations();

  Future<Organization> createOrganization();

  Future<Organization> updateOrganization();

  Future<void> deleteOrganization(String uuid);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<Organization>> getOrganizationByUser(String userUuid);
}
