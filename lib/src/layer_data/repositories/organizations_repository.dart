import 'package:genesis/src/layer_data/requests/organizations/create_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/delete_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/edit_organization_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organizations_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_organizations_api.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class OrganizationsRepository implements IOrganizationsRepository {
  OrganizationsRepository(this._organizationsApi);

  final IOrganizationsApi _organizationsApi;

  @override
  Future<Organization> createOrganization(params) async {
    final req = CreateOrganizationReq(params);
    final dto = await _organizationsApi.createOrganization(req);
    return dto.toEntity();
  }

  @override
  Future<void> deleteOrganization(params) async {
    final req = DeleteOrganizationReq(params);
    await _organizationsApi.deleteOrganization(req);
  }

  @override
  Future<Organization> getOrganizationByUuid(String uuid) {
    // TODO: implement getOrganizationByUuid
    throw UnimplementedError();
  }

  @override
  Future<List<Organization>> getOrganizations(params) async {
    final req = GetOrganizationsReq(params);
    final listOfOrganizationDto = await _organizationsApi.getOrganizations(req);
    return listOfOrganizationDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Organization> editOrganization(params) async {
    final req = EditOrganizationReq(params);
    final dto = await _organizationsApi.editOrganization(req);
    return dto.toEntity();
  }

  @override
  Future<List<Organization>> getOrganizationByUser(String userUuid) async {
    final listOfOrganizationDto = await _organizationsApi.getOrganizationByUser(userUuid);
    return listOfOrganizationDto.map((dto) => dto.toEntity()).toList();
  }
}
