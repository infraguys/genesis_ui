import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/common/shared_entities/organization.dart';
import 'package:genesis/src/features/organizations/data/dtos/organization_dto.dart';
import 'package:genesis/src/features/organizations/data/dtos/organization_member_dto.dart';
import 'package:genesis/src/features/organizations/data/source/remote/i_organizations_api.dart';

final class OrganizationsApi implements IOrganizationsApi {
  OrganizationsApi(this._client);

  final RestClient _client;

  static const _organizationMembersUrl = '/v1/iam/organization_members/';

  @override
  Future<Organization> createOrganization() {
    // TODO: implement createOrganization
    throw UnimplementedError();
  }

  @override
  Future<void> deleteOrganization(String uuid) {
    // TODO: implement deleteOrganization
    throw UnimplementedError();
  }

  @override
  Future<List<OrganizationDto>> getOrganizationByUser(String userUuid) async {
    final url = '$_organizationMembersUrl?user=$userUuid';
    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        final membersDto = castedData.map((it) => OrganizationMemberDto.fromJson(it)).toList();

        final futures = <Future<Response<Map<String, dynamic>>>>[];

        for (var it in membersDto) {
          if (it.organizationsSource != null) {
            final future = _client.get<Map<String, dynamic>>(it.organizationsSource!);
            futures.add(future);
          }
        }
        final organizationsData = await futures.wait;
        return organizationsData.map((response) {
          return OrganizationDto.fromJson(response.data!);
        }).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<Organization> getOrganizationByUuid(String uuid) {
    // TODO: implement getOrganizationByUuid
    throw UnimplementedError();
  }

  @override
  Future<List<Organization>> getOrganizations() {
    // TODO: implement getOrganizations
    throw UnimplementedError();
  }

  @override
  Future<Organization> updateOrganization() {
    // TODO: implement updateOrganization
    throw UnimplementedError();
  }
}
