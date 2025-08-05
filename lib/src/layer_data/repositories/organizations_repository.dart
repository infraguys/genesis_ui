import 'package:genesis/src/layer_data/requests/get_organizations_req.dart';
import 'package:genesis/src/layer_data/requests/organizations/create_organization_req.dart';
import 'package:genesis/src/layer_data/source/remote/i_organizations_api.dart';
import 'package:genesis/src/layer_domain/entities/organization.dart';
import 'package:genesis/src/layer_domain/params/create_organization_params.dart';
import 'package:genesis/src/layer_domain/params/get_organizations_params.dart';
import 'package:genesis/src/layer_domain/params/update_organiztion_params.dart';
import 'package:genesis/src/layer_domain/repositories/i_organizations_repository.dart';

final class OrganizationsRepository implements IOrganizationsRepository {
  OrganizationsRepository(this._organizationsApi);

  final IOrganizationsApi _organizationsApi;

  @override
  Future<Organization> createOrganization(CreateOrganizationParams params) async {
    final req = CreateOrganizationReq(params);
    final dto = await _organizationsApi.createOrganization(req);
    return dto.toEntity();
  }

  @override
  Future<void> deleteOrganization(String uuid) {
    // TODO: implement deleteOrganization
    throw UnimplementedError();
  }

  @override
  Future<Organization> getOrganizationByUuid(String uuid) {
    // TODO: implement getOrganizationByUuid
    throw UnimplementedError();
  }

  @override
  Future<List<Organization>> getOrganizations(GetOrganizationsParams params) async {
    final req = GetOrganizationsReq(params);
    final listOfOrganizationDto = await _organizationsApi.getOrganizations(req);
    return listOfOrganizationDto.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Organization> updateOrganization(UpdateOrganizationParams params) {
    // TODO: implement updateOrganization
    throw UnimplementedError();
  }

  @override
  Future<List<Organization>> getOrganizationByUser(String userUuid) async {
    final listOfOrganizationDto = await _organizationsApi.getOrganizationByUser(userUuid);
    return listOfOrganizationDto.map((dto) => dto.toEntity()).toList();
  }
}
