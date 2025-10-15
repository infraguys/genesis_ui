import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organization_params.dart';

abstract interface class IOrganizationsRepository {
  Future<List<Organization>> getOrganizations(GetOrganizationsParams params);

  Future<Organization> createOrganization(CreateOrganizationParams params);

  Future<Organization> getOrganization(OrganizationID id);

  Future<Organization> updateOrganization(UpdateOrganizationParams params);

  Future<void> deleteOrganization(OrganizationID id);
}
