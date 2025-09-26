import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/permission_binding_dto.dart';
import 'package:genesis/src/layer_data/requests/permission_binding_requests/get_permission_bindings_req.dart';
import 'package:genesis/src/layer_data/source/remote/permission_bindings_api/i_permission_bindings_api.dart';

final class PermissionBindingsApi implements IPermissionBindingsApi {
  PermissionBindingsApi(this._client);

  final RestClient _client;

  @override
  Future<List<PermissionBindingDto>> getPermissionBindings(GetPermissionBindingsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );

      if (data != null) {
        final dtos = List.castFrom<dynamic, Map<String, dynamic>>(data).map(PermissionBindingDto.fromJson);
        return dtos.toList();
      }
      return List.empty();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<PermissionBindingDto> createPermissionBinding(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data == null) {
        throw DataNotFoundException(requestOptions.uri.path);
      }
      return PermissionBindingDto.fromJson(data);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  @override
  Future<void> deletePermissionBinding(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.delete<Map<String, dynamic>>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
