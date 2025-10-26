import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/dtos/database_dto.dart';
import 'package:genesis/src/features/dbaas/data/requests/database_requests/create_database_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/database_requests/database_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/database_requests/get_databases_req.dart';
import 'package:genesis/src/features/dbaas/data/requests/database_requests/update_database_req.dart';

final class DatabasesApi {
  DatabasesApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  Future<DatabaseDto> getDatabase(DatabaseReq req) async {
    try {
      final Response(:data) = await _client.get<Map<String, dynamic>>(
        req.toPath(),
      );
      return DatabaseDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<void> deleteDatabase(DatabaseReq req) async {
    try {
      await _client.delete<void>(
        req.toPath(),
      );
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<DatabaseDto> createDatabase(CreateDatabaseReq req) async {
    try {
      final Response(:data) = await _client.post<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return DatabaseDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  Future<DatabaseDto> updateDatabase(UpdateDatabaseReq req) async {
    try {
      final Response(:data) = await _client.put<Map<String, dynamic>>(
        req.toPath(),
        data: req.toJson(),
      );
      return DatabaseDto.fromJson(data!);
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

  /// Multiple instances methods
  ///
  /// Методы для работы с несколькими экземплярами

  Future<List<DatabaseDto>> getDatabases(GetDatabasesReq req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => DatabaseDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }
}
