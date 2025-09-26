import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/organization_requests/get_organizations_req.dart';
import 'package:genesis/src/layer_data/source/remote/organizations_api/i_organizations_api.dart';

final class OrganizationsApi implements IOrganizationsApi {
  OrganizationsApi(this._client);

  final RestClient _client;

  @override
  Future<OrganizationDto> createOrganization(req) async {
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

  @override
  Future<void> deleteOrganization(req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
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

  @override
  Future<OrganizationDto> editOrganization(req) async {
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

  @override
  Future<OrganizationDto> getOrganization(req) async {
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
