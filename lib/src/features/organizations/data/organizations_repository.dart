import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/data/source/remote/i_organizations_api.dart';
import 'package:genesis/src/features/organizations/domain/params/create_organization_params.dart';
import 'package:genesis/src/features/organizations/domain/params/get_organizations_params.dart';
import 'package:genesis/src/features/organizations/domain/params/update_organiztion_params.dart';
import 'package:genesis/src/features/organizations/domain/repositories/i_organizations_repository.dart';

final class OrganizationsRepository implements IOrganizationsRepository {
  OrganizationsRepository(this._organizationsApi);

  final IOrganizationsApi _organizationsApi;

  @override
  Future<Organization> createOrganization(CreateOrganizationParams params) {
    // TODO: implement createOrganization
    throw UnimplementedError();
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
  Future<List<Organization>> getOrganizations(GetOrganizationsParams params) {
    // TODO: implement getOrganizations
    throw UnimplementedError();
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
