import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/extensions/data/dtos/extension_dto.dart';
import 'package:genesis/src/features/extensions/data/requests/get_extensions_req.dart';
import 'package:genesis/src/features/extensions/domain/entities/extension.dart';

final class ExtensionsApi {
  ExtensionsApi(this._client);

  final RestClient _client;

  Future<ExtensionDto> getExtension(ExtensionID id) {
    // TODO: implement getExtension
    throw UnimplementedError();
  }

  Future<List<ExtensionDto>> getExtensions(GetExtensionsReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => ExtensionDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
