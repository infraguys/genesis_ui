import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/use_cases/create_organization_params.dart';
import 'package:genesis/src/layer_domain/use_cases/get_organizations_params.dart';
import 'package:genesis/src/layer_domain/use_cases/update_organiztion_params.dart';

abstract interface class IOrganizationsRepository {
  Future<List<Organization>> getOrganizations(GetOrganizationsParams params);

  Future<Organization> createOrganization(CreateOrganizationParams params);

  Future<Organization> updateOrganization(UpdateOrganizationParams params);

  Future<void> deleteOrganization(String uuid);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<Organization>> getOrganizationByUser(String userUuid);
}
