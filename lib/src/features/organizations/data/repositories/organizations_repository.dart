import 'package:genesis/src/features/organizations/domain/entities/organization.dart';
import 'package:genesis/src/features/organizations/data/requests/create_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/delete_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/edit_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/get_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/get_organizations_req.dart';
import 'package:genesis/src/features/organizations/data/sources/organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class OrganizationsRepository implements IOrganizationsRepository {
  OrganizationsRepository(this._organizationsApi);

  final OrganizationsApi _organizationsApi;

  @override
  Future<Organization> createOrganization(params) async {
    final dto = await _organizationsApi.createOrganization(CreateOrganizationReq(params));
    return dto.toEntity();
  }

  @override
  Future<void> deleteOrganization(uuid) async {
    await _organizationsApi.deleteOrganization(DeleteOrganizationReq(uuid));
  }

  @override
  Future<List<Organization>> getOrganizations(params) async {
    final dtos = await _organizationsApi.getOrganizations(GetOrganizationsReq(params));
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Organization> updateOrganization(params) async {
    final dto = await _organizationsApi.updateOrganization(UpdateOrganizationReq(params));
    return dto.toEntity();
  }

  @override
  Future<Organization> getOrganization(uuid) async {
    final dto = await _organizationsApi.getOrganization(GetOrganizationReq(uuid));
    return dto.toEntity();
  }
}
