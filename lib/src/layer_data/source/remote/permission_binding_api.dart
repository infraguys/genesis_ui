import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/permission_binding_dto.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_permission_bindings_api.dart';

final class PermissionBindingsApi implements IPermissionBindingsApi {
  PermissionBindingsApi(this._client);

  final RestClient _client;

  @override
  Future<PermissionBindingDto> createPermissionBinding(req) async {
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      if (data != null) {
        return PermissionBindingDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
