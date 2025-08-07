import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/source/remote/i_role_bindings_api.dart';

final class RoleBindingsApi implements IRoleBindingsApi {
  RoleBindingsApi(this._client);

  final RestClient _client;

  static const _roleBindingsUrl = '/v1/iam/role_bindings/';

  @override
  Future<void> createRoleBinding(req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(_roleBindingsUrl),
        data: req.toJson(),
      );
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
