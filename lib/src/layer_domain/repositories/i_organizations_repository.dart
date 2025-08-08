import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/get_organizations_params.dart';
import 'package:genesis/src/layer_domain/params/organizations/create_organization_params.dart';
import 'package:genesis/src/layer_domain/params/organizations/delete_organization_params.dart';
import 'package:genesis/src/layer_domain/params/organizations/edit_organiztion_params.dart';

abstract interface class IOrganizationsRepository {
  Future<List<Organization>> getOrganizations(GetOrganizationsParams params);

  Future<Organization> createOrganization(CreateOrganizationParams params);

  Future<Organization> updateOrganization(UpdateOrganizationParams params);

  Future<void> deleteOrganization(DeleteOrganizationParams params);

  Future<Organization> getOrganizationByUuid(String uuid);

  Future<List<Organization>> getOrganizationByUser(String userUuid);
}
