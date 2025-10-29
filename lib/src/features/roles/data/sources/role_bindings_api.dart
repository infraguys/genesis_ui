import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/roles/data/dtos/role_binding_dto.dart';
import 'package:genesis/src/features/roles/data/requests/create_role_binding_req.dart';
import 'package:genesis/src/features/roles/data/requests/delete_role_binding_req.dart';
import 'package:genesis/src/features/roles/data/requests/get_role_bindings_req.dart';

final class RoleBindingsApi {
  RoleBindingsApi(this._client);

  final RestClient _client;

  Future<void> createRoleBinding(CreateRoleBindingReq req) async {
    try {
      final Response() = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<List<RoleBindingDto>> getRoleBindings(GetRoleBindingsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final dtos = List.castFrom<dynamic, Map<String, dynamic>>(data).map(RoleBindingDto.fromJson);
      return dtos.toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteRoleBinding(DeleteRoleBindingReq req) async {
    try {
      await _client.delete<Map<String, dynamic>>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
