import 'package:genesis/src/layer_data/requests/organization_requests/create_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/delete_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/edit_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/get_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/get_organizations_req.dart';
import 'package:genesis/src/layer_data/source/remote/organizations_api/i_organizations_api.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class OrganizationsRepository implements IOrganizationsRepository {
  OrganizationsRepository(this._organizationsApi);

  final IOrganizationsApi _organizationsApi;

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
    final dto = await _organizationsApi.editOrganization(UpdateOrganizationReq(params));
    return dto.toEntity();
  }

  @override
  Future<Organization> getOrganization(uuid) async {
    final dto = await _organizationsApi.getOrganization(GetOrganizationReq(uuid));
    return dto.toEntity();
  }
}
