import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/network_exception.dart';
import 'package:genesis/src/core/rest_client/rest_client.dart';
import 'package:genesis/src/features/role/data/dtos/role_dto.dart';
import 'package:genesis/src/features/role/data/source/remote/i_roles_api.dart';

final class RolesApi implements IRolesApi {
  RolesApi(this._client);

  final RestClient _client;

  static const _userUrl = '/v1/iam/users/';

  @override
  Future<List<RoleDto>> getRolesByUserUuid(String userUuid) async {
    final url = '$_userUrl/$userUuid/actions/get_my_roles';

    try {
      final Response(:data, :requestOptions) = await _client.get<List<dynamic>>(
        url,
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
          },
        ),
      );
      if (data != null) {
        final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
        return castedData.map((it) => RoleDto.fromJson(it)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw NetworkException(e);
    }
  }
}
