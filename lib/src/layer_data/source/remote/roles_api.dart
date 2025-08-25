import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/role_dto.dart';
import 'package:genesis/src/layer_data/requests/roles/create_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/delete_role_req.dart';
import 'package:genesis/src/layer_data/requests/roles/get_roles_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_roles_api.dart';

final class RolesApi implements IRolesApi {
  RolesApi(this._client);

  final RestClient _client;

  static const _userUrl = '/v1/iam/users/';

  @override
  Future<List<RoleDto>> getRolesByUserUuid(String userUuid) async {
    final url = '$_userUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data, :requestOptions) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => RoleDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<RoleDto> createRole(CreateRoleReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data != null) {
        return RoleDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<RoleDto>> getRoles(GetRolesReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => RoleDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<void> deleteRole(DeleteRoleReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<RoleDto> getRole(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return RoleDto.fromJson(data);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
