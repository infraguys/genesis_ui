import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/roles/data/dtos/role_dto.dart';
import 'package:genesis/src/features/roles/data/requests/create_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/delete_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_role_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_roles_req.dart';
import 'package:genesis/src/features/roles/data/requests/update_role_req.dart';

final class RolesApi {
  RolesApi(this._client);

  final RestClient _client;

  static const _userUrl = '/v1/iam/users/';

  Future<List<RoleDto>> getRolesByUserUuid(String userUuid) async {
    final url = '$_userUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data) = await _client.get<List<dynamic>>(url);
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => RoleDto.fromJson(it)).toList();
      }
      return List.empty();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<RoleDto> createRole(CreateRoleReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return RoleDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<List<RoleDto>> getRoles(GetRolesReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => RoleDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteRole(DeleteRoleReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<RoleDto> getRole(GetRoleReq req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );

      return RoleDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<RoleDto> updateRole(UpdateRoleReq req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return RoleDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
