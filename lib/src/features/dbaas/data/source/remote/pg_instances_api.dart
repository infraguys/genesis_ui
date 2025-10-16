import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/dtos/pg_instance_dto.dart';
import 'package:genesis/src/features/dbaas/data/requests/create_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/delete_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/get_pg_instances_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/update_pg_instance_req.dart';
import 'package:genesis/src/features/dbaas/domain/params/create_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/delete_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instance_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/get_pg_instances_params.dart';
import 'package:genesis/src/features/dbaas/domain/params/update_pg_instance_params.dart';

final class PgInstancesApi {
  PgInstancesApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  Future<PgInstanceDto> getPgInstance(GetPgInstanceParams params) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        params.toPath(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deletePgInstance(DeletePgInstanceParams params) async {
    try {
      await _client.delete<void>(
        params.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgInstanceDto> createPgInstance(CreatePgInstanceParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
        data: params.toJson(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<PgInstanceDto> updatePgInstance(UpdatePgInstanceParams params) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        params.toPath(),
        data: params.toJson(),
      );
      return PgInstanceDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  /// Multiple instances methods
  ///
  /// Методы для работы с несколькими экземплярами

  Future<List<PgInstanceDto>> getPgInstances(GetPgInstancesParams params) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        params.toPath(),
        queryParameters: params.toQuery(),
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
