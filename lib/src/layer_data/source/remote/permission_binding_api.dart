import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/source/remote/i_permission_bindings_api.dart';

final class PermissionBindingApi implements IPermissionBindingsApi {
  PermissionBindingApi(this._client);

  final RestClient _client;

  static const _permissionBindingsUrl = '/v1/iam/permission_bindings/';

  @override
  Future<void> createPermissionBinding(String role, String permissionUuid) async {
    const url = _permissionBindingsUrl;
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        url,
        data: {
          'role': '/v1/iam/roles/$role',
          'permission': '/v1/iam/permissions/$permissionUuid',
        },
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
