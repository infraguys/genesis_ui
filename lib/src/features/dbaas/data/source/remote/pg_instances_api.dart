import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/layer_data/dtos/pg_instance_dto.dart';
import 'package:genesis/src/layer_data/requests/pg_instances_requests/get_pg_instances_req.dart';
import 'package:genesis/src/layer_domain/entities/pg_instance.dart';

final class PgInstancesApi {
  PgInstancesApi(this._client);

  final RestClient _client;

  Future<PGInstanceDto> getPgInstance(PGInstanceUUID uuid) async {
    // TODO: implement getPGInstance
    throw UnimplementedError();
  }

  Future<List<PGInstanceDto>> getPgInstances(GetPgInstancesReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => PGInstanceDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deletePgInstance(PGInstanceUUID uuid) async {
    // TODO: implement deletePGInstance
    throw UnimplementedError();
  }
}
