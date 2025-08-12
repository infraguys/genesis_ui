import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/roles_bindings.dart';
import 'package:genesis/src/layer_data/requests/role_bindings/get_role_bindings_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_role_bindings_api.dart';

final class RoleBindingsApi implements IRoleBindingsApi {
  RoleBindingsApi(this._client);

  final RestClient _client;

  @override
  Future<void> createRoleBinding(req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }

  @override
  Future<List<RolesBindingDto>> getRoleBindings(GetRoleBindingsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => RolesBindingDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
