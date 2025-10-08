import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/permission_dto.dart';
import 'package:genesis/src/layer_data/requests/permission_requests/get_permission_req.dart';

final class PermissionsApi {
  PermissionsApi(this._client);

  final RestClient _client;

  Future<PermissionDto> createPermission() {
    // TODO: implement createPermission
    throw UnimplementedError();
  }

  Future<PermissionDto> getPermission() {
    // TODO: implement getPermission
    throw UnimplementedError();
  }

  Future<List<PermissionDto>> getPermissions(GetPermissionsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );

      if (data == null) {
        return List.empty();
      }

      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => PermissionDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
