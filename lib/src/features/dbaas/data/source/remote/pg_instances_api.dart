import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/dtos/pg_instance_dto.dart';
import 'package:genesis/src/features/dbaas/data/requests/create_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/delete_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instances_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/update_pg_instance_req.dart';

final class PgInstancesApi {
  PgInstancesApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  Future<PgInstanceDto> getPgInstance(GetPgInstanceReq req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deletePgInstance(DeletePgInstanceReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgInstanceDto> createPgInstance(CreatePgInstanceReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgInstanceDto> updatePgInstance(UpdatePgInstanceReq req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  /// Multiple instances methods
  ///
  /// Методы для работы с несколькими экземплярами

  Future<List<PgInstanceDto>> getPgInstances(GetPgInstancesReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => PgInstanceDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
