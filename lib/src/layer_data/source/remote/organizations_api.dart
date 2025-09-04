import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/organization_dto.dart';
import 'package:genesis/src/layer_data/requests/organizations/get_organizations_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_organizations_api.dart';

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
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return OrganizationDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<void> deleteOrganization(req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
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
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => OrganizationDto.fromJson(it)).toList();
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
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return OrganizationDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<OrganizationDto> getOrganization(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return OrganizationDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
