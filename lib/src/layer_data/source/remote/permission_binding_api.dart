import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/data_not_found_exception.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/permission_dto.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_permission_bindings_api.dart';

final class PermissionBindingApi implements IPermissionBindingsApi {
  PermissionBindingApi(this._client);

  final RestClient _client;

  static const _permissionBindingsUrl = '/iam/permission_bindings/';

  @override
  Future<PermissionDto> createPermissionBinding(req) async {
    const url = _permissionBindingsUrl;
    try {
      final Response(:data, :requestOptions) = await _client.post<Map<String, dynamic>>(
        url,
        data: req.toJson(),
      );
      if (data != null) {
        return PermissionDto.fromJson(data);
      }
      throw DataNotFoundException(requestOptions.uri.path);
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
