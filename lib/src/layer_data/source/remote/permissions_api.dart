import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/permission_dto.dart';
import 'package:genesis/src/layer_data/requests/get_permission_req.dart';
import 'package:genesis/src/layer_data/source/remote/interfaces/i_permissions_api.dart';

final class PermissionsApi implements IPermissionsApi {
  PermissionsApi(this._client);

  final RestClient _client;

  static const String _permissionsUrl = '/v1/iam/permissions/';

  @override
  Future<PermissionDto> createPermission() {
    // TODO: implement createPermission
    throw UnimplementedError();
  }

  @override
  Future<PermissionDto> getPermission() {
    // TODO: implement getPermission
    throw UnimplementedError();
  }

  @override
  Future<List<PermissionDto>> getPermissions(GetPermissionsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(_permissionsUrl),
        queryParameters: req.toQuery(),
      );

      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => PermissionDto.fromJson(it)).toList();
      }

      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
