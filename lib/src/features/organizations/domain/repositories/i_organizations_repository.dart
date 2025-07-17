import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organiztion_params.dart';

abstract interface class IOrganizationsRepository {

  Future<List<Organization>> getOrganizations(GetOrganizationsParams params);

  Future<Organization> createOrganization(CreateOrganizationParams params);

  Future<Organization> updateOrganization(UpdateOrganizationParams params);

  Future<void> deleteOrganization(String uuid);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<Organization>> getOrganizationByUser(String userUuid);
}
