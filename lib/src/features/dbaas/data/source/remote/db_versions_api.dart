import 'package:dio/dio.dart';
import 'package:genesis/src/core/exceptions/base_network_exception.dart';
import 'package:genesis/src/core/network/rest_client/rest_client.dart';
import 'package:genesis/src/features/dbaas/data/dtos/db_version_dto.dart';
import 'package:genesis/src/features/dbaas/data/requests/db_versions_requests/get_db_versions_req.dart';
import 'package:genesis/src/features/dbaas/domain/params/db_versions_params/get_db_versions_params.dart';

final class DbVersionsApi {
  DbVersionsApi(this._client);

  final RestClient _client;

  /// Single instance methods
  ///
  /// Методы для работы с одним экземпляром

  // Future<DbVersionDto> getDatabase(GetDbVersionsParams req) async {
  //   try {
  //     final Response(:data) = await _client.get<Map<String, dynamic>>(
  //       req.toPath(),
  //     );
  //     return DbVersionDto.fromJson(data!);
  //   } on DioException catch (e) {
  //     throw BaseNetworkException.from(e);
  //   }
  // }

  // Future<void> deleteDatabase(DatabaseParams req) async {
  //   try {
  //     await _client.delete<void>(
  //       req.toPath(),
  //     );
  //   } on DioException catch (e) {
  //     throw BaseNetworkException.from(e);
  //   }
  // }

  // Future<DatabaseDto> createDatabase(CreateDatabaseParams req) async {
  //   try {
  //     final Response(:data) = await _client.post<Map<String, dynamic>>(
  //       req.toPath(),
  //       data: req.toJson(),
  //     );
  //     return DatabaseDto.fromJson(data!);
  //   } on DioException catch (e) {
  //     throw BaseNetworkException.from(e);
  //   }
  // }

  // Future<DatabaseDto> updateDatabase(UpdateDatabaseParams req) async {
  //   try {
  //     final Response(:data) = await _client.put<Map<String, dynamic>>(
  //       req.toPath(),
  //       data: req.toJson(),
  //     );
  //     return DatabaseDto.fromJson(data!);
  //   } on DioException catch (e) {
  //     throw BaseNetworkException.from(e);
  //   }
  // }

  // /// Multiple instances methods
  // ///
  // /// Методы для работы с несколькими экземплярами

  Future<List<DbVersionDto>> getDbVersions(GetDbVersionsParams req) async {
    try {
      final Response(:data) = await _client.get<List<dynamic>>(
        req.toPath(),
        queryParameters: req.toQuery(),
      );
      if (data == null) {
        return List.empty();
      }
      final castedData = List.castFrom<dynamic, Map<String, dynamic>>(data);
      return castedData.map((it) => DbVersionDto.fromJson(it)).toList();
    } on DioException catch (e) {
      throw BaseNetworkException.from(e);
    }
  }

}
