import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/organizations/data/dtos/organization_dto.dart';
import 'package:genesis/src/features/organizations/data/requests/create_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/delete_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/edit_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/get_organization_req.dart';
import 'package:genesis/src/features/organizations/data/requests/get_organizations_req.dart';

final class OrganizationsApi {
  OrganizationsApi(this._client);

  final RestClient _client;

  Future<OrganizationDto> createOrganization(CreateOrganizationReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return OrganizationDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteOrganization(DeleteOrganizationReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<List<OrganizationDto>> getOrganizations(GetOrganizationsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => OrganizationDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<OrganizationDto> updateOrganization(UpdateOrganizationReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return OrganizationDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<OrganizationDto> getOrganization(GetOrganizationReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return OrganizationDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
