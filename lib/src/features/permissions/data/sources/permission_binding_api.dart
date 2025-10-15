import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/permissions/data/dtos/permission_binding_dto.dart';
import 'package:genesis/src/features/permissions/data/requests/create_permission_binding_req.dart';
import 'package:genesis/src/features/permissions/data/requests/delete_permission_binding_req.dart';
import 'package:genesis/src/features/permissions/data/requests/get_permission_bindings_req.dart';

final class PermissionBindingsApi {
  PermissionBindingsApi(this._client);

  final RestClient _client;

  Future<List<PermissionBindingDto>> getPermissionBindings(GetPermissionBindingsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );

      if (data == null) {
        return List.empty();
      }
      final dtos = List.castFrom<dynamic, Map<String, dynamic>>(data).map(PermissionBindingDto.fromJson);
      return dtos.toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PermissionBindingDto> createPermissionBinding(CreatePermissionBindingReq req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return PermissionBindingDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deletePermissionBinding(DeletePermissionBindingReq req) async {
    try {
      await _client.delete<Map<String, dynamic>>(req.toPath());
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
