import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/dtos/organization_member_dto.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organizations_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_organizations_api.dart';

final class OrganizationsApi implements IOrganizationsApi {
  OrganizationsApi(this._client);

  final RestClient _client;

  static const _organizationMembersUrl = '/iam/organization_members/';

  @override
  Future<OrganizationDto> createOrganization(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data != null) {
        return OrganizationDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<void> deleteOrganization(req) async {
    try {
      await _client.delete<List<dynamic>>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
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
  Future<OrganizationDto> getOrganizationByUuid(String uuid) {
    // TODO: implement getOrganizationByUuid
    throw UnimplementedError();
  }

  @override
  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => OrganizationDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<OrganizationDto> editOrganization(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data != null) {
        return OrganizationDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
